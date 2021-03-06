-----------------------------------------------------------------------
--------------------------------MUX A----------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity Mux8x1A is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		x: in std_logic;
		c: out std_logic_vector(15 downto 0)
	);
end Mux8x1A;

architecture Mux8x1A of Mux8x1A is
begin
	c <= a when x = '0' else b;
end Mux8x1A;


---------------------------------------------------------
-----------------COMPARADOR 1----------------------------
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity comparador1 is
	port (
		a: in std_logic;
		b: in std_logic;
		c: out std_logic_vector(1 downto 0)
		--11: =, 01: <, 10: >, 00: error
	);
end comparador1;

architecture comparador1 of comparador1 is
begin
	c <= "11" when (a = b) else
		"01" when (a = '0' and b = '1') else
		"10" when (a = '1' and b = '0') else
		"00"; --error
end comparador1;

---------------------------------------------------------
-----------------COMPARADOR 16----------------------------
---------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity comparador16 is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		s: out std_logic_vector(1 downto 0)
		--11: =, 01: <, 10: >, 00: error
	);
end comparador16;

architecture comparador16 of comparador16 is
	component comparador1
	port(
		a, b: in std_logic;
		c: out std_logic_vector(1 downto 0)
	);
	end component;
	signal c15, c14, c13, c12, c11, c10, c9, c8, c7, c6, c5, c4, c3, c2, c1, c0: std_logic_vector(1 downto 0);
begin
	--[C]omparador[X][I]ndice[Y]
	--c1i15: comparador1 port map (a(15), b(15), c15);
	--verificando se número > 0
	c15 <= "00" when a(15) = '1' or b(15) = '1' else "11";
	c1i14: comparador1 port map (a(14), b(14), c14);
	c1i13: comparador1 port map (a(13), b(13), c13);
	c1i12: comparador1 port map (a(12), b(12), c12);
	c1i11: comparador1 port map (a(11), b(11), c11);
	c1i10: comparador1 port map (a(10), b(10), c10);
	c1i9: comparador1 port map (a(9), b(9), c9);
	c1i8: comparador1 port map (a(8), b(8), c8);
	c1i7: comparador1 port map (a(7), b(7), c7);
	c1i6: comparador1 port map (a(6), b(6), c6);
	c1i5: comparador1 port map (a(5), b(5), c5);
	c1i4: comparador1 port map (a(4), b(4), c4);
	c1i3: comparador1 port map (a(3), b(3), c3);
	c1i2: comparador1 port map (a(2), b(2), c2);
	c1i1: comparador1 port map (a(1), b(1), c1);
	c1i0: comparador1 port map (a(0), b(0), c0);
	s <= c15 when not (c15 = "11") else
		c14 when not (c14 = "11") else
		c13 when not (c13 = "11") else
		c12 when not (c12 = "11") else
		c11 when not (c11 = "11") else
		c10 when not (c10 = "11") else
		c9 when not (c9 = "11") else
		c8 when not (c8 = "11") else
		c7 when not (c7 = "11") else
		c6 when not (c6 = "11") else
		c5 when not(c5 = "11") else
		c4 when not(c4 = "11") else
		c3 when not(c3 = "11") else
		c2 when not(c2 = "11") else
		c1 when not(c1 = "11") else
		c0;
end comparador16;

-----------------------------------------------------------------------
--------------------------SOMADOR 1 BIT--------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity somador1bit is
	port (
		a: in std_logic;
		b: in std_logic;
		cin: in std_logic;
		s: out std_logic;
		cout: out std_logic
	);
end somador1bit;

architecture somador1bit of somador1bit is
begin
	cout <= (cin and a) or (cin and b) or (a and b);
	s <= (not cin and not a and b) or (not cin and a and not b)
		or (cin and not a and not b) or (cin and a and b);
end somador1bit;


-----------------------------------------------------------------------
--------------------------SOMADOR 16 BITS-------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity somador16bits is
	port (
		a: in std_logic_vector(15 downto 0);
		b: in std_logic_vector(15 downto 0);
		cin: in std_logic;
		s: out std_logic_vector(15 downto 0);
		cout: out std_logic
	);
end somador16bits;

architecture somador16bits of somador16bits is
	component somador1bit
	port (
		a, b, cin: in std_logic;
		s, cout: out std_logic
	);
	end component;

	signal ta, tb, ts: std_logic_vector(15 downto 0);
	signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15: std_logic;
begin
	ta <= a;
	tb <= b when cin = '0' else not b;
	s8b0: somador1bit port map (a(0), tb(0), cin, ts(0), c0);
	s8v1: somador1bit port map (a(1), tb(1), c0, ts(1), c1);
	s8v2: somador1bit port map (a(2), tb(2), c1, ts(2), c2);
	s8v3: somador1bit port map (a(3), tb(3), c2, ts(3), c3);
	s8v4: somador1bit port map (a(4), tb(4), c3, ts(4), c4);
	s8v5: somador1bit port map (a(5), tb(5), c4, ts(5), c5);
	s8v6: somador1bit port map (a(6), tb(6), c5, ts(6), c6);
	s8v7: somador1bit port map (a(7), tb(7), c6, ts(7), c7);
	s8b8: somador1bit port map (a(8), tb(8), c7, ts(8), c8);
	s8v9: somador1bit port map (a(9), tb(9), c8, ts(9), c9);
	s8v10: somador1bit port map (a(10), tb(10), c9, ts(10), c10);
	s8v11: somador1bit port map (a(11), tb(11), c10, ts(11), c11);
	s8v12: somador1bit port map (a(12), tb(12), c11, ts(12), c12);
	s8v13: somador1bit port map (a(13), tb(13), c12, ts(13), c13);
	s8v14: somador1bit port map (a(14), tb(14), c13, ts(14), c14);
	s8v15: somador1bit port map (a(15), tb(15), c14, ts(15), c15);
	--verifica overflow e underflow
	cout <= (not a(15) and not tb(15) and ts(15)) or (a(15) and tb(15) and not ts(15));
	s <= ts;
end somador16bits;



--REGISTRADOR 16 BIT

library ieee;
use ieee.std_logic_1164.all;

entity reg_paraleload is
	port ( i: in std_logic_vector (15 downto 0);
		clk, ld, clr: in std_logic; --load: 1: escrita, 0: leitura
		q: out std_logic_vector (15 downto 0)
	);
end;

architecture reg_paraleload of reg_paraleload is
begin
	process (ld, clk, clr)
	begin
		if (clk'event and clk = '1') then
			if (clr = '1') then
				q <= "0000000000000000";
			elsif (ld = '1') then
				q <= i;
			end if;
		end if;
	end process;
end reg_paraleload;


-----------------------------------------------------------------------
-------------------------------DIVISOR---------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity divisor is
	port (
		a, b: in std_logic_vector (15 downto 0);
		LerA, clk, ld, clr: in std_logic;
		erro, ContSubt: out std_logic;
		resul, resto: out std_logic_vector (15 downto 0)
	);
end;

architecture divisor of divisor is
	component Mux8x1A
		port (
			a: in std_logic_vector(15 downto 0);
			b: in std_logic_vector(15 downto 0);
			x: in std_logic;
			c: out std_logic_vector(15 downto 0)
		);
	end component;
	component comparador16
		port (
			a: in std_logic_vector(15 downto 0);
			b: in std_logic_vector(15 downto 0);
			s: out std_logic_vector(1 downto 0)
			--11: =, 01: <, 10: >, 00: error
		);
	end component;
	component somador16bits
		port (
			a: in std_logic_vector(15 downto 0);
			b: in std_logic_vector(15 downto 0);
			cin: in std_logic;
			s: out std_logic_vector(15 downto 0);
			cout: out std_logic
		);
	end component;
	component reg_paraleload
		port ( i: in std_logic_vector (15 downto 0);
			clk, ld, clr: in std_logic; --load: 1: escrita, 0: leitura
			q: out std_logic_vector (15 downto 0)
		);
	end component;

	signal bv, av, ContSub2: std_logic_vector(1 downto 0); --b/a valid //ver se continua subtraindo
	signal FromMuxToReg, FromRegSub, FromRegSum, FromSub, FromAdd: std_logic_vector (15 downto 0);
	signal ContSum, coutsum, coutsub: std_logic;
begin
	Bvalid: comparador16 port map (b, "0000000000000000", bv);
	Avalid: comparador16 port map (a, "0000000000000000", av);
	erro <= '1' when (bv = "11" or bv = "00" or av = "00") else '0';
	fmtr: Mux8x1A port map(a, FromSub, LerA, FromMuxToReg);
	RegA: reg_paraleload port map (FromMuxToReg, clk, ld, clr, FromRegSub);
	KeepSub: comparador16 port map (FromRegSub, b, ContSub2);
	ContSubt <= '1' when (ContSub2 = "11" or ContSub2 = "10") else '0';
	ContSum <= '1' when ((ContSub2 = "11" or ContSub2 = "10") and ld = '1') else '0';
	RegRes: reg_paraleload port map (FromAdd, clk, ContSum, clr, FromRegSum);
	sub: somador16bits port map (FromRegSub, b, '1', FromSub, coutsub);
	add: somador16bits port map (FromRegSum, "0000000000000001", '0', FromAdd, coutsum);
	resul <= FromRegSum;
	resto <= FromRegSub;
end divisor;


-----------------------------------------------------------------------
-------------------------------FSM-------------------------------------
-----------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
entity fsm IS
port ( clk, erroin, calcular, ContSub: in std_logic;
		concl, errout, clr, lera, ld: out std_logic;
		state: out std_logic_vector (2 downto 0) );
end;

architecture fsm of fsm is
	constant WAITT: std_logic_vector (2 DOWNTO 0) := "000";
	constant VERIFICAB: std_logic_vector (2 DOWNTO 0) := "001";
	constant ERRO: std_logic_vector (2 DOWNTO 0) := "010";
	constant VERIFICADIV: std_logic_vector (2 downto 0) := "011";
	constant SUBTRAI: std_logic_vector (2 downto 0) := "100";
	constant TERMINA: std_logic_vector (2 downto 0) := "101";
	signal st: std_logic_vector (2 downto 0) := WAITT;
begin
	PROCESS (clk, st)
	BEGIN
		if (clk'event and clk = '1') then
			case st is
				when WAITT =>
					if (calcular = '1') then
						st <= VERIFICAB;
					else
						st <= WAITT;
					end if;
				when VERIFICAB =>
					if (erroin = '1') then
						st <= ERRO;
					else
						st <= VERIFICADIV;
					end if;
				when ERRO =>
					st <= WAITT;
				when VERIFICADIV =>
					if (ContSub = '1') then
						st <= SUBTRAI;
					else
						st <= TERMINA;
					end if;
				when SUBTRAI =>
					st <= VERIFICADIV;
				when others =>
					st <= WAITT;
			end case;
		end if;
		if (st = WAITT) then
			lera <= '0';
			ld <= '0';
			errout <= '0';
			concl <= '0';
			clr <= '1';
		elsif (st = VERIFICAB) then
			ld <= '1';
			clr <= '0';
		elsif (st = ERRO) then
			errout <= '1';
			concl <= '1';
		elsif (st = VERIFICADIV) then
			lera <= '1';
		elsif (st = TERMINA) then
			ld <= '0';
			concl <= '1';
		end if;
	end process;
	state <= st;
end fsm;

-----------------------------------------------------------------------
-------------------------------RTL-------------------------------------
-----------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
entity rtl IS
port ( clk, calcular: in std_logic;
		a, b: in std_logic_vector (15 downto 0);
		concl, errout: out std_logic;
		state: out std_logic_vector (2 downto 0);
		resul, resto: out std_logic_vector (15 downto 0)
		);
end;

architecture rtl of rtl is
	component fsm is
	port ( clk, erroin, calcular, ContSub: in std_logic;
			concl, errout, clr, lera, ld: out std_logic;
			state: out std_logic_vector (2 downto 0) );
	end component;
	component divisor is
		port (
			a, b: in std_logic_vector (15 downto 0);
			LerA, clk, ld, clr: in std_logic;
			erro, ContSubt: out std_logic;
			resul, resto: out std_logic_vector (15 downto 0)
		);
	end component;
	signal errodiv, contsubdiv, clrfsm, lerafsm, ldfsm: std_logic;
begin
	pc: fsm port map (clk, errodiv, calcular, contsubdiv, concl, errout, clrfsm, lerafsm, ldfsm, state);
	po: divisor port map (a, b, lerafsm, clk, ldfsm, clrfsm, errodiv, contsubdiv, resul, resto);
end rtl;
