library ieee;
use ieee.std_logic_1164.all;

entity MSS is
port ( 	Clock, Resetn: IN STD_LOGIC;
			SetOK, TimeOK, Fotocelda, FIN: 	IN STD_LOGIC;
			estado: OUT STD_LOGIC_VECTOR(3 downto 0);
			SEL_clk,en_reg,SEL1,en_res,ld_res,Encendido: OUT STD_LOGIC);
end MSS;

architecture behavior of MSS is
type est is (A,B,C,D,F,G,H,I,J,K,L);
signal y: est;
begin 
	MSS_transiciones: process (Resetn, Clock)
	begin
	if Resetn='0' then y <= A;
	elsif (Clock'event and Clock ='1') then 
		case y is
			when A => if SetOK='1' then y <= B; else y <= A; end if;
			when B => y <= C;
			when C => y <= D;
			when D => if (TimeOK='1' and Fotocelda='0') then y <=F; else  y <=D;end if;
			when F => y <= G;
			when G => y <= H;
			when H => y <= I;
			when I => y <= J;
			when J => y <= K;
			when K => if FIN='0' then y <= L; else y <= A; end if;
			when L => y <= F;
		end case;
	end if;
	end process;
	
	MSS_salidas: process (y)
	begin
		SEL_clk<= '0';en_reg<= '0';SEL1<= '0';en_res<= '0';ld_res<= '0';Encendido<= '0';estado<="0000";
		case y is
			when A =>
			when B => en_reg<= '1';estado<="0001";
			when C => SEL1<= '1';en_res<= '1';ld_res<= '1';estado<="0010";
			when D => SEL1<= '1';estado<="0011";
			when F => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="0100";
			when G => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="0101";
			when H => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="0110";
			when I => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="0111";
			when J => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="1000";
			when K => SEL_clk<= '1';Encendido<= '1';SEL1<= '1';estado<="1001";
			when L => Encendido<= '1';en_res<= '1';SEL1<= '1';estado<="1010";
		end case;
	end process;
end behavior;