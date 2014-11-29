--REGISTRADOR 16 BIT

library ieee;
use ieee.std_logic_1164.all;

entity reg_paraleload is
	port ( i: in std_logic_vector (15 downto 0);
		clk, ld, rst: in std_logic; --load: 1: escrita, 0: leitura
		q: out std_logic_vector (15 downto 0)
	);
end;

architecture reg_paraleload of reg_paraleload is
begin
	q <=  "0000000000000000" when (clk'event and clk = '1' and rst = '1') else
		i when ( clk'event and clk = '1' and ld = '1' );
--	process (ld, clk)
--	begin
--		if (clk'event and clk = '1' and ld = '1') then
--			q <= i;
--		end if;
--	end process;
end reg_paraleload;



--BANCO REGISTRADORES

library ieee;
use ieee.std_logic_1164.all;

entity banco_reg is
	port ( write: in std_logic_vector (15 downto 0);
		regnum: in std_logic_vector (2 downto 0); --armazena número do registrador
		clk, ld, rst: in std_logic;
		read: out std_logic_vector (15 downto 0)
	);
end;

architecture banco_reg of banco_reg is
	component reg_paraleload port (
		i: in std_logic_vector (15 downto 0);
		clk, ld, rst: in std_logic; --load: 1: escrita, 0: leitura
		q: out std_logic_vector (15 downto 0)
	);
	end component;
	
	signal clk0, clk1, clk2, clk3, clk4, clk5, clk6, clk7: std_logic;
	signal r0, r1, r2, r3, r4, r5, r6, r7: std_logic_vector(15 downto 0);

begin
	--calcula o clk direto, caso não passe o ld direto (utilizando ld0), dá erro na simulação. PQ???
	--código comentado ao final da arquitetura é o q gerava erro
	clk0 <= '1' when ( clk'event and clk = '1' and ( regnum = "000" or rst = '1' ) ) else '0';
	clk1 <= '1' when ( clk'event and clk = '1' and ( regnum = "001" or rst = '1' ) ) else '0';
	clk2 <= '1' when ( clk'event and clk = '1' and ( regnum = "010" or rst = '1' ) ) else '0';
	clk3 <= '1' when ( clk'event and clk = '1' and ( regnum = "011" or rst = '1' ) ) else '0';
	clk4 <= '1' when ( clk'event and clk = '1' and ( regnum = "100" or rst = '1' ) ) else '0';
	clk5 <= '1' when ( clk'event and clk = '1' and ( regnum = "101" or rst = '1' ) ) else '0';
	clk6 <= '1' when ( clk'event and clk = '1' and ( regnum = "110" or rst = '1' ) ) else '0';
	clk7 <= '1' when ( clk'event and clk = '1' and ( regnum = "111" or rst = '1' ) ) else '0';

	reg0: reg_paraleload port map (write, clk0, ld, rst, r0);
	reg1: reg_paraleload port map (write, clk1, ld, rst, r1);
	reg2: reg_paraleload port map (write, clk2, ld, rst, r2);
	reg3: reg_paraleload port map (write, clk3, ld, rst, r3);
	reg4: reg_paraleload port map (write, clk4, ld, rst, r4);
	reg5: reg_paraleload port map (write, clk5, ld, rst, r5);
	reg6: reg_paraleload port map (write, clk6, ld, rst, r6);
	reg7: reg_paraleload port map (write, clk7, ld, rst, r7);

	read <= r0 when clk0 = '1' else r1 when clk1 = '1' else
		r2 when clk2 = '1' else r3 when clk3 = '1' else
		r4 when clk4 = '1' else r5 when clk5 = '1' else
		r6 when clk6 = '1' else r7 when clk7 = '1';

	--CÓDIGO BUGADO PQ NÃO SEI
--	ld0 <= '1' when ld = '1' and regnum = "000" else '0';
--	ld1 <= '1' when ld = '1' and regnum = "001" else '0';
--	ld2 <= '1' when ld = '1' and regnum = "010" else '0';
--	ld3 <= '1' when ld = '1' and regnum = "011" else '0';
--	ld4 <= '1' when ld = '1' and regnum = "100" else '0';
--	ld5 <= '1' when ld = '1' and regnum = "101" else '0';
--	ld6 <= '1' when ld = '1' and regnum = "110" else '0';
--	ld7 <= '1' when ld = '1' and regnum = "111" else '0';

--	reg0: reg_paraleload port map (write, clk, ld0, r0);
--	reg1: reg_paraleload port map (write, clk, ld1, r1);
--	reg2: reg_paraleload port map (write, clk, ld2, r2);
--	reg3: reg_paraleload port map (write, clk, ld3, r3);
--	reg4: reg_paraleload port map (write, clk, ld4, r4);
--	reg5: reg_paraleload port map (write, clk, ld5, r5);
--	reg6: reg_paraleload port map (write, clk, ld6, r6);
--	reg7: reg_paraleload port map (write, clk, ld7, r7);

--	read <= r0 when ( regnum = "000" and clk'event and clk = '1' )
--		else r1 when ( regnum = "001" and clk'event and clk = '1' )
--		else r2 when ( regnum = "010" and clk'event and clk = '1' )
--		else r3 when ( regnum = "011" and clk'event and clk = '1' )
--		else r4 when ( regnum = "100" and clk'event and clk = '1' )
--		else r5 when ( regnum = "101" and clk'event and clk = '1' )
--		else r6 when ( regnum = "110" and clk'event and clk = '1' )
--		else r7 when ( regnum = "111" and clk'event and clk = '1' );
end banco_reg;
