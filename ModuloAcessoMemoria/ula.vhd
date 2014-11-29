-----------------------------------------------------------------------
---------------------------------PC------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity memacc_pc IS
port ( clk, clr, do_op, op_done_ula: in std_logic;
		do_op_ula, op_done: out std_logic;
		state: out std_logic_vector (2 downto 0)
);
end memacc_pc;

architecture memacc_pc of memacc_pc is
	constant STWAIT: std_logic_vector (2 downto 0) := "000";
	constant STRESET: std_logic_vector (2 downto 0) := "001";
	constant STLERA: std_logic_vector (2 downto 0) := "010";
	constant STLERB: std_logic_vector (2 downto 0) := "011";
	constant STWAITOP: std_logic_vector (2 downto 0) := "100";
	constant STWAITWR: std_logic_vector (2 downto 0) := "101";
	signal st: std_logic_vector (2 downto 0);
begin
	PROCESS (clk)
	BEGIN
		if (clk'event and clk = '1') then
			case st is
				when STWAIT =>
					if (clr'event and clr = '1') then
						st <= STRESET;
					elsif (do_op'event and do_op = '1') then
						st <= STLERA;
					end if;
				when STLERA =>
					st <= STLERB;
				when STLERB =>
					st <= STWAITOP;
				when STWAITOP =>
					if (op_done_ula = '1') then
						st <= STWAITWR;
					end if;
				when others =>
					st <= STWAIT;
			end case;
		end if;
	end process;

	do_op_ula <= '1' when st = STWAITOP else '0';
	op_done <= '1' when st = STWAIT else '0';
	state <= st;
end memacc_pc;

-----------------------------------------------------------------------
---------------------------------PO------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity memacc_po is
	port (
		--estado da pc
		st: in std_logic_vector (2 downto 0);
		--instrução, registrador, memória ram, resultado ula
		inst_in, from_reg, from_ram, from_ula: in std_logic_vector(15 downto 0);
		--se operação da ula deu over/underflow
		erro_ula: in std_logic;
		--valor da operação a ser exibido na saída, valor para ram, valor para registrador
		--A p/ operação na ULA, B p/ operação na ULA
		val_ram, end_ram, val_reg, ula_a, ula_b: out std_logic_vector(15 downto 0);
		--endereço a ser lido/escrito do registrador
		end_reg : out std_logic_vector (2 downto 0);
		--se operação da ula deu over/underflow (exibido na saída)
		--se escreve (1) ou lê da ram (0) / se escreve (1) ou lê dos registradores (0)
		-- ula_x, ula_y e ula_z definem a operação a ser efetuada pela ULA
		esc_ram, esc_reg, rst_reg, ula_x, ula_y, ula_z: out std_logic
	);
end memacc_po;

architecture memacc_po of memacc_po is

	constant STWAIT: std_logic_vector (2 downto 0) := "000";
	constant STRESET: std_logic_vector (2 downto 0) := "001";
	constant STLERA: std_logic_vector (2 downto 0) := "010";
	constant STLERB: std_logic_vector (2 downto 0) := "011";
	constant STWAITOP: std_logic_vector (2 downto 0) := "100";
	constant STWAITWR: std_logic_vector (2 downto 0) := "101";

	signal opcode : std_logic_vector(3 downto 0);
begin
	opcode <= inst_in (15 downto 12);
	rst_reg <= '1' when st = STRESET else '0';
	--demux
	end_reg <= inst_in(11 downto 9) when st = STLERA else
		inst_in (5 downto 3) when st = STWAITWR and opcode(3) = '0' else
		inst_in(8 downto 6) when (st = STLERB and (opcode(3) = '0' or opcode = "1001")) or
		(st = STWAITWR and (opcode = "1000" or opcode = "1110"));

	ula_a <= from_reg when st = STLERA;
	
	--seleciona se vai receber valor da constante ou de RB dependendo do opcode
		--mux
	ula_b <= from_reg when st = STLERB and opcode(3) = '0' else
			"0000000000" & inst_in(5 downto 0) when st = STLERB and opcode(3) = '1';
		--endmux
	--enddemux
	--operações de escrita
	--quando opcode = 0xxx ou 1110, ou seja, valor vem da ula
		--verifica se irá escrever no registrador (só salva valor válido)
	esc_reg <= '1' when st = STWAITWR and erro_ula = '0' and ( opcode(3) = '0' or opcode = "1110" 
	--quando opcode = 1000, escreve, no registrador, valor vindo da memória
		or  opcode = "1000" )  else '0';
		--atualiza valor a ser salvo no registrador
	val_reg <= from_ula when st = STWAITWR and ( opcode(3) = '0' or opcode = "1110" ) else
		from_ram when st = STWAITWR and opcode = "1000";

	--atualizará o endereço a ser consultado na memória
	end_ram <= from_ula when st = STWAITWR and opcode (3 downto 1) = "100";

	--quando opcode = 1001, escreve, na memória, valor vindo do registrador
	esc_ram <= '0' when st = STWAITWR and opcode = "1000" else
		'1' when st = STWAITWR and opcode = "1001" and erro_ula = '0' else '0';

	val_ram <= from_reg when st = STWAITWR and opcode = "1001";
	--escolhe operação baseado em opcode
	ula_x <= opcode(2) when opcode(3) = '0' else '0';
	ula_y <= opcode(1) when opcode(3) = '0' else '0';
	ula_z <= opcode(0) when opcode(3) = '0' else '0';
	
end memacc_po;

-----------------------------------------------------------------------
-------------------------------MEMACC----------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity memacc is
	port (
		clk, clr, do_op, op_done_ula: in std_logic;
		inst_in, from_reg, from_ram, from_ula: in std_logic_vector(15 downto 0);
		erro_ula: in std_logic;


		do_op_ula, op_done: out std_logic;
		val_ram, end_ram, val_reg, ula_a, ula_b: out std_logic_vector(15 downto 0);
		end_reg, stat : out std_logic_vector (2 downto 0);
		esc_ram, esc_reg, rst_reg, ula_x, ula_y, ula_z: out std_logic
	);
end memacc;

architecture memacc of memacc is

	component memacc_pc
	port (
		clk, clr, do_op, op_done_ula: in std_logic;
		do_op_ula, op_done: out std_logic;
		state: out std_logic_vector (2 downto 0)
	);
	end component;

	component memacc_po
	port (
		st: in std_logic_vector (2 downto 0);
		inst_in, from_reg, from_ram, from_ula: in std_logic_vector(15 downto 0);
		erro_ula: in std_logic;
		val_ram, end_ram, val_reg, ula_a, ula_b: out std_logic_vector(15 downto 0);
		end_reg : out std_logic_vector (2 downto 0);
		esc_ram, esc_reg, rst_reg, ula_x, ula_y, ula_z: out std_logic
	);
	end component;

	signal st: std_logic_vector (2 downto 0);

begin
	memaccpc: memacc_pc port map (clk, clr, do_op, op_done_ula, do_op_ula, op_done, st);
	memaccpo: memacc_po port map (st, inst_in, from_reg, from_ram, from_ula, erro_ula, val_ram,
		end_ram, val_reg, ula_a, ula_b, end_reg, esc_ram, esc_reg, rst_reg, ula_x, ula_y, ula_z);
	stat <= st;
end memacc;
