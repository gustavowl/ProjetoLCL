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


		op_done_ula, erro_ula: in std_logic;
		from_ram, from_ula: in std_logic_vector (15 downto 0);

		do_op_ula, op_done: out std_logic;
		val_ram, end_ram, ula_a, ula_b: out std_logic_vector(15 downto 0);
		stat : out std_logic_vector (2 downto 0);
			esc_reg2: out std_logic;
			from_reg2, val_reg2: out std_logic_vector (15 downto 0);
			end_reg2 : out std_logic_vector (2 downto 0);
		esc_ram, ula_x, ula_y, ula_z: out std_logic
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

	signal save_instru, do_next_instru, reset, esc_reg, rst_reg: std_logic;
	signal instru, from_reg, val_reg: std_logic_vector (15 downto 0);
	signal end_reg : std_logic_vector (2 downto 0);

begin
	PointOfEntry: entry port map (clk, clr, valid, do_operation, switches, save_instru, do_next_instru, reset, instru);
	ModAccMem: memacc port map ( clk, clr, do_next_instru, op_done_ula, instru, from_reg, from_ram, from_ula, erro_ula,
		do_op_ula, op_done, val_ram, end_ram, val_reg, ula_a, ula_b, end_reg, stat, esc_ram, esc_reg, rst_reg, ula_x,
		ula_y, ula_z);

	BancoReg: banco_reg port map (val_reg, end_reg, clk, esc_reg, clr, from_reg);

	val_reg2 <= val_reg;
	end_reg2 <= end_reg;
	from_reg2 <= from_reg;
	esc_reg2 <= esc_reg;
end cdd;