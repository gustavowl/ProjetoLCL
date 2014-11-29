library ieee;
use ieee.std_logic_1164.all;

entity ula_tb is
end ula_tb;

architecture ula_tb of ula_tb is
	signal sclk, sclr, sdo_op, sop_done_ula: std_logic;
	signal sinst_in, sfrom_reg, sfrom_ram, sfrom_ula: std_logic_vector(15 downto 0);
	signal serro_ula: std_logic;


	signal sdo_op_ula, sop_done: std_logic;
	signal sval_ram, send_ram, sval_reg, sula_a, sula_b: std_logic_vector(15 downto 0);
	signal send_reg : std_logic_vector (2 downto 0);
	signal sesc_ram, sesc_reg, srst_reg, sula_x, sula_y, sula_z: std_logic;
	signal sstat: std_logic_vector(2 downto 0);
begin
	vector: entity work.memacc
	port map (
		clk => sclk,
		clr => sclr,
		do_op => sdo_op,
		op_done_ula => sop_done_ula,
		inst_in => sinst_in,
		from_reg => sfrom_reg,
		from_ram => sfrom_ram,
		from_ula => sfrom_ula,
		erro_ula => serro_ula,

		do_op_ula => sdo_op_ula,
		op_done => sop_done,
		val_ram => sval_ram,
		end_ram => send_ram,
		val_reg => sval_reg,
		ula_a => sula_a,
		ula_b => sula_b,
		end_reg => send_reg,
		esc_ram => sesc_ram,
		esc_reg => sesc_reg,
		rst_reg => srst_reg,
		ula_x => sula_x,
		ula_y => sula_y,
		ula_z => sula_z,
		stat => sstat

	);

	process
	begin
		wait;
	end process;
end ula_tb;
