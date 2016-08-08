-- LIBRARY HEADER MATERIAL --
LIBRARY altera;
USE altera.maxplus2.all;
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
-- LIBRARY HEADER MATERIAL --

--entity definition
entity ALU is
port (
	opcode: IN std_logic_vector (4 downto 0); -- 8 bit opcode inputs
	inA: IN std_logic_vector (7 downto 0); -- 8 bit input bus,
	inB: IN std_logic_vector (7 downto 0); -- 8 bit input bus
	clock: IN std_logic;
	result: OUT std_logic_vector (7 downto 0); -- 8 bit output
	flagN, flagC, flagZ: OUT std_logic);
end ALU;
--end

architecture behavioural of ALU is
begin
process (clock)
variable acc: std_logic_vector (7 downto 0);
variable temp: std_logic_vector(8 downto 0);
begin
if(clock'event and  clock = '1') then
case opcode is

	-- addition
	when "11011" =>
		acc := inA + inB;


	-- bitwise AND
	when "10100" =>
		acc := inA AND inB;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;



	-- clear && clear ACC
	when "01111" =>
		acc := "00000000";
			flagN <= '0';
			flagZ <= '1';
			result <= acc;

	-- compare
	when "10001" =>
	acc := inB - inA;
		if(inB = inA) then
			-- temp := ("0" & inA)  ("0" & inB);
			if(acc < 0) then
				flagN <= '1';
			elsif(acc = 0) then
				flagZ <= '1';
			else
				flagN <= '0';
				flagZ <= '0';
				flagC <= '0';
			end if;
		end if;
		result <= acc;

	-- ones compliment && ones compliment ACC
	when "00011" =>
		acc := NOT(inA);
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			flagC <= '1';
			result <= acc;


	-- decrement & decrement ACC
	when "01010" =>
		acc := inA - 1;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;

	-- exclusive OR
	when "11000" =>
		acc := inB XOR inA;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;

	-- increment && increment ACC
	when "01100" =>
		acc := inA + 1;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;

	-- load ACC
	when "10110" =>
		flagN <= '0';
		flagZ <= '0';
		result <= acc;

	-- logical shift left && logical shift left ACC
	when "01000" =>
		acc := inA(6 downto 0) & "0";
		temp := "00000000" & inA(7 downto 7);
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		elsif(temp = 000000001) then		-- ugly as dog poo but it works!
			flagC <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
			flagC <= '0';
		end if;
			result <= acc;

	-- logical shift right && logical shift right ACC
	when "00100" =>
		acc := "0" & inA(7 downto 1);
		temp := "00000000" & inA(7 downto 7);
		if(acc = 0) then
			flagZ <= '1';
		elsif(temp = 000000001) then		-- what the hell do we need a carry for a SR operation?? ref: http://teaching.idallen.com/dat2343/10f/notes/040_overflow.txt
			flagC <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
			flagC <= '0';
		end if;
			flagN <= '0';
			result <= acc;

	-- move immediate
	when "01110" =>
		acc := inA;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;

	-- bitwise OR
	when "11010" =>
		acc := inA OR inB;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
		end if;
			result <= acc;

	-- store ACC
	when "10111" =>
		flagN <= '0';
		flagZ <= '0';
		result <= acc;

	-- subtract
	when "10000" =>
		acc := inA - inB;
		if(acc < 0) then
			flagN <= '1';
		elsif(acc = 0) then
			flagZ <= '1';
		elsif(inA < inB) then
			flagC <= '1';
		else
			flagN <= '0';
			flagZ <= '0';
			flagC <= '0';
		end if;
			result <= acc;

	when others =>
		flagN <= '0';

end case;
end if;
end process;
end behavioural;
