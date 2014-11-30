library ieee;
use ieee.std_logic_1164.all;

entity cdd_tb is
end cdd_tb;

architecture cdd_tb of cdd_tb is
	signal sclk, sclr, svalid, sdo_op: std_logic;
	signal sswitches: std_logic_vector (15 downto 0);


	signal sop_done_ula: std_logic;
	signal sfrom_reg2, sfrom_ram2, sfrom_ula: std_logic_vector(15 downto 0);
	signal serro_ula: std_logic;


	signal sdo_op_ula, sop_done: std_logic;
	signal sval_ram2, send_ram2, sval_reg2, sula_a, sula_b: std_logic_vector(15 downto 0);
	signal send_reg2 : std_logic_vector (2 downto 0);
	signal sesc_ram2, sesc_reg2, sula_x, sula_y, sula_z, sula_st: std_logic;
	signal sstat: std_logic_vector(2 downto 0);


	signal sled_op_over, sled_doing_op, sled_reset, sled_erro_ula : std_logic;
	signal sdisplays: std_logic_vector(15 downto 0);

begin
	vector: entity work.cdd
	port map (
		clk => sclk,
		clr => sclr,
		valid => svalid,
		do_operation => sdo_op,
		switches => sswitches,


		op_done_ula2 => sop_done_ula,
		from_reg2 => sfrom_reg2,
		from_ram2 => sfrom_ram2,
		from_ula2 => sfrom_ula,
		erro_ula2 => serro_ula,
		do_op_ula2 => sdo_op_ula,
		op_done2 => sop_done,
		val_ram2 => sval_ram2,
		end_ram2 => send_ram2,
		val_reg2 => sval_reg2,
		ula_a2 => sula_a,
		ula_b2 => sula_b,
		end_reg2 => send_reg2,
		esc_ram2 => sesc_ram2,
		esc_reg2 => sesc_reg2,
		ula_x2 => sula_x,
		ula_y2 => sula_y,
		ula_z2 => sula_z,
		stat => sstat,
		ula_st2 => sula_st,



		led_op_over => sled_op_over,
		led_doing_op => sled_doing_op,
		led_reset => sled_reset,
		led_erro_ula => sled_erro_ula,
		displays => sdisplays
	);

	process
	begin
		wait;
	end process;
end cdd_tb;
