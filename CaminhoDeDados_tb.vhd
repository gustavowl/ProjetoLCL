library ieee;
use ieee.std_logic_1164.all;

entity cdd_tb is
end cdd_tb;

architecture cdd_tb of cdd_tb is
	signal sclk, sclr, svalid, sdo_op: std_logic;
	signal sswitches: std_logic_vector (15 downto 0);


	signal sop_done_ula: std_logic;
	signal sfrom_reg2, sfrom_ram, sfrom_ula: std_logic_vector(15 downto 0);
	signal serro_ula: std_logic;


	signal sdo_op_ula, sop_done: std_logic;
	signal sval_ram, send_ram, sval_reg2, sula_a, sula_b: std_logic_vector(15 downto 0);
	signal send_reg2 : std_logic_vector (2 downto 0);
	signal sesc_ram, sesc_reg2, sula_x, sula_y, sula_z: std_logic;
	signal sstat: std_logic_vector(2 downto 0);

begin
	vector: entity work.cdd
	port map (
		clk => sclk,
		clr => sclr,
		valid => svalid,
		do_operation => sdo_op,
		switches => sswitches,


		op_done_ula => sop_done_ula,
		from_reg2 => sfrom_reg2,
		from_ram => sfrom_ram,
		from_ula => sfrom_ula,
		erro_ula => serro_ula,
		do_op_ula => sdo_op_ula,
		op_done => sop_done,
		val_ram => sval_ram,
		end_ram => send_ram,
		val_reg2 => sval_reg2,
		ula_a => sula_a,
		ula_b => sula_b,
		end_reg2 => send_reg2,
		esc_ram => sesc_ram,
		esc_reg2 => sesc_reg2,
		ula_x => sula_x,
		ula_y => sula_y,
		ula_z => sula_z,
		stat => sstat
	);

	process
	begin
		wait;
	end process;
end cdd_tb;
