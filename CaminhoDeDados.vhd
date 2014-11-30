-----------------------------------------------------------------------
--------------------------CAMINHO-DE-DADOS-----------------------------
-----------------------------------------------------------------------
-----------------------------------------------------------------------
-------------------------------FSM-------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity cdd IS
port (
	clk, clr, valid, do_operation: in std_logic;
	switches: in std_logic_vector(15 downto 0);


			op_done_ula2, erro_ula2: out std_logic;
			from_ula2: out std_logic_vector (15 downto 0);

			do_op_ula2, op_done2: out std_logic;
			from_ram2, val_ram2, end_ram2, ula_a2, ula_b2: out std_logic_vector(15 downto 0);
		stat : out std_logic_vector (2 downto 0);
			esc_reg2: out std_logic;
			from_reg2, val_reg2: out std_logic_vector (15 downto 0);
			end_reg2 : out std_logic_vector (2 downto 0);
			esc_ram2, ula_x2, ula_y2, ula_z2, ula_st2: out std_logic;




			led_op_over, led_doing_op, led_reset, led_erro_ula : out std_logic;
			displays2: out std_logic_vector(15 downto 0);

			disp3: out std_logic_vector (0 to 6); --MS dlay
			disp2: out std_logic_vector (0 to 6); --dlay de 7 segmentos
			disp1: out std_logic_vector (0 to 6); --dlay de 7 segmentos
			disp0: out std_logic_vector (0 to 6)  --LS dlay
);
end cdd;

architecture cdd of cdd is
	component entry
	port (
		clk, clr, valid, do_operation: in std_logic;
		switches: in std_logic_vector(15 downto 0);
		save_instru, do_next_instru, reset: out std_logic;
		instru: out std_logic_vector (15 downto 0)
	);
	end component;

	component memacc is
		port (
			clk, clr, do_op, op_done_ula: in std_logic;
			inst_in, from_reg, from_ram, from_ula: in std_logic_vector(15 downto 0);
			erro_ula: in std_logic;

			do_op_ula, op_done: out std_logic;
			val_ram, end_ram, val_reg, ula_a, ula_b: out std_logic_vector(15 downto 0);
			end_reg, stat : out std_logic_vector (2 downto 0);
			esc_ram, esc_reg, rst_reg, ula_x, ula_y, ula_z: out std_logic
		);
	end component;

	component banco_reg is
		port ( write: in std_logic_vector (15 downto 0);
			regnum: in std_logic_vector (2 downto 0); --armazena número do registrador
			clk, ld, rst: in std_logic;
			read: out std_logic_vector (15 downto 0)
		);
	end component;

	component ram is
		generic (
		    DATA_WIDTH : integer := 16;
		    ADDR_WIDTH : integer := 16
		);
		port (
		    clock  : in std_logic;
		    wren   : in std_logic;
		    addr   : in std_logic_vector(ADDR_WIDTH - 1 downto 0);
		    data_i : in std_logic_vector(DATA_WIDTH - 1 downto 0);
		    data_o : out std_logic_vector(DATA_WIDTH - 1 downto 0)
		);
	end component;

	component ula is
		port (
			a: in std_logic_vector(15 downto 0);
			b: in std_logic_vector(15 downto 0);
			x, y, z, clk, do_op: in std_logic;
			s: out std_logic_vector(15 downto 0);
			couterro, done, state: out std_logic
		);
	end component;

	component modsaida is
		port ( 
			clk, op_over, reset, erro_ula: in std_logic;
			result: in std_logic_vector (15 downto 0);
			led_op_over, led_doing_op , led_reset, led_erro_ula: out std_logic;
			displays: out std_logic_vector (15 downto 0)

		);
	end component;

	component decodhex16bit is
		port (
			entry: in std_logic_vector(15 downto 0);
			d3: out std_logic_vector (0 to 6); --MS dlay
			d2: out std_logic_vector (0 to 6); --dlay de 7 segmentos
			d1: out std_logic_vector (0 to 6); --dlay de 7 segmentos
			d0: out std_logic_vector (0 to 6)  --LS dlay
			--dlays: 0:a, 1:b, 2:c, 3:d, 4:e, 5:f, 6:g
		);
	end component;

	signal save_instru, do_next_instru, reset, esc_reg, rst_reg, esc_ram, ula_x, ula_y, ula_z, do_op_ula, erro_ula,
		op_done_ula, ula_st, op_done: std_logic;
	signal instru, from_reg, val_reg, end_ram, val_ram, from_ram, ula_a, ula_b, from_ula, displays: std_logic_vector (15 downto 0);
	signal end_reg : std_logic_vector (2 downto 0);

begin
	PointOfEntry: entry port map (clk, clr, valid, do_operation, switches, save_instru, do_next_instru, reset, instru);
	ModAccMem: memacc port map ( clk, clr, do_next_instru, op_done_ula, instru, from_reg, from_ram, from_ula, erro_ula,
		do_op_ula, op_done, val_ram, end_ram, val_reg, ula_a, ula_b, end_reg, stat, esc_ram, esc_reg, rst_reg, ula_x,
		ula_y, ula_z);

	op_done2 <= op_done;

	BancoReg: banco_reg port map (val_reg, end_reg, clk, esc_reg, clr, from_reg);
	val_reg2 <= val_reg;
	end_reg2 <= end_reg;
	from_reg2 <= from_reg;
	esc_reg2 <= esc_reg;

	MemRam: ram port map (clk, esc_ram, end_ram, val_ram, from_ram);
	esc_ram2 <= esc_ram;
	end_ram2 <= end_ram;
	val_ram2 <= val_ram;
	from_ram2 <= from_ram;

	UnidLogArit: ula port map(ula_a, ula_b, ula_x, ula_y, ula_z, clk, do_op_ula, from_ula, erro_ula, op_done_ula, ula_st);
	ula_a2 <= ula_a;
	ula_b2 <= ula_b;
	ula_x2 <= ula_x;
	ula_y2 <= ula_y;
	ula_z2 <= ula_z;
	do_op_ula2 <= do_op_ula;
	from_ula2 <= from_ula;
	erro_ula2 <= erro_ula;
	op_done_ula2 <= op_done_ula;
	ula_st2 <= ula_st;

	ModuloSaida: modsaida port map (clk, op_done, clr, erro_ula, from_ula, led_op_over, led_doing_op, led_reset, led_erro_ula,
		displays);
	displays2 <= displays;
	
	Decodificador: decodhex16bit port map (displays, disp3, disp2, disp1, disp0);
end cdd;
