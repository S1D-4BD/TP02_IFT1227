--controller

--Celina Sid Abdelkader, 2024-10-22
--IFT1227

--Machine a bonbons, fsm de Moore à 10 etats et affichage sur 4  7-segments (2 pour le reste, 2 pour la somme)


library IEEE;use IEEE.STD_LOGIC_1164.ALL;

entity controller is
	Port (
		clk : in  STD_LOGIC;   -- Clock 
		reset : in  STD_LOGIC;   -- Reset 
		in5  : in  STD_LOGIC;   -- swt 5 cents
		in10 : in  STD_LOGIC;   -- swt 10 cents
		in25 : in  STD_LOGIC;   -- swt 25 cents (bit le plus significatif dans le input
		somme: out STD_LOGIC_VECTOR(3 downto 0); --le bus pour afficher le total
		reste: out STD_LOGIC_VECTOR(2 downto 0); -- bus pr afficher ce quil faut remettre
		bonbon: out STD_LOGIC 							-- pr moi
);
end controller;

architecture synth of controller is

		-- les etats = toutes les sommes possibles
		type state_type is (etat0, etat5, etat10, etat15, etat20, etat25, etat30, etat35, etat40, etat45);
		signal state, next_state : state_type;

begin
    --------------
    -- transition 
	process(clk, reset)
   begin
		if reset = '1' then
			state <= etat0; 
		elsif rising_edge(clk) then -- ma clock est une switch, qd la switch est a 1 le d-flip flop laissera passer l'input D du rising edge vers Q (next state)
			state <= next_state; 
		end if;
	end process;

   -----------------------------------------------------------------------------------------------------------------------
   -- Processus transition:  en fct des 3 pieces qu'on peut mettre et l'etat ou on est, on va ou et qu'est ce qu'on affiche
	process(state, in5, in10, in25)
	begin
   -- 
		somme <= "0000";  
		reste <= "000"; 
		bonbon <= '0'; 

      -----------------------------------
		--case des etats + OUTPUT sur 7 seg
		
	case state is
	------------------------------------------
	---ETAT 0 
		when etat0 => -- etat initial, 0 c lus
			if in5 = '1' then
				next_state <= etat5;
					  
 			elsif in10 = '1' then
				next_state <= etat10;
						  
 			 elsif in25 = '1' then
				next_state <= etat25;
			else
					 
				next_state <= etat0;
			 end if;
					 
				somme <= "0000"; -- affiche 00
	---FIN ETAT 0------------------------------
	
	
	---ETAT 5 ---------------------------------
		when etat5 => 
			if in5 = '1' then
				next_state <= etat10;
						  
			elsif in10 = '1' then
				next_state <= etat15;
						  
			elsif in25 = '1' then
				next_state <= etat30;
			  
			else
				next_state <= etat5;
						  
			end if;
				somme <= "0001"; 
	---FIN ETAT 5 -----------------------------
	
	
	---ETAT 10 --------------------------------
		when etat10 => 
			if in5 = '1' then
				next_state <= etat15;
		 elsif in10 = '1' then
				next_state <= etat20;
		elsif in25 = '1' then
				next_state <= etat35;
				 --reste <= "010";
		else
 			next_state <= etat10;
		end if;
				somme <= "0010"; 
	---FIN ETAT 10 ----------------------------

	
	---ETAT 15 --------------------------------
		when etat15 =>
			if in5 = '1' then
				next_state <= etat20;
						  
			elsif in10 = '1' then
				next_state <= etat25;
						  
			 --bonbon <= '1';
			elsif in25 = '1' then
				next_state <= etat40;
			else
				 next_state <= etat15;
						  
			end if;
			 somme <= "0011";
	---FIN ETAT 15 ---------------------------- 

	
	---ETAT 20 --------------------------------		
			when etat20 => 
				if in5 = '1' then
			next_state <= etat25;
						  
				elsif in10 = '1' then
					next_state <= etat30;
                  
				elsif in25 = '1' then
					next_state <= etat45;	  
			else
				next_state <= etat20;
			end if;
				 somme <= "0100"; 
	---FIN ETAT 20 ---------------------------
	

	---ETAT 25  ------------------------------		
			when etat25 => 
				bonbon <= '1'; -- bonbon 
				 next_state <= etat0;
					 
				somme <= "1000"; 
					 reste <= "000";
					  -- OUTPUT: 00 25
	---FIN ETAT 25----------------------------
	
	
	---ETAT 30 -------------------------------
			when etat30 => 
				bonbon <= '1'; 
				reste <= "001"; 
				next_state <= etat0;
				 somme <= "1001";  
					  -- OUTPUT: 05 30
	---FIN ETAT 30 ---------------------------
	
	
	--- ETAT 35 ------------------------------
			 when etat35 => 
				bonbon <= '1'; 
				reste <= "010";
				next_state <= etat0;
				somme <= "1010"; 
					  -- OUTPUT: 10 35
	---FIN ETAT 35 ---------------------------
	
	
	---ETAT 40 -------------------------------
			 when etat40 => 
				 bonbon <= '1'; 
				reste <= "011"; 
 				next_state <= etat0;
				somme <= "1011"; 
					 -- OUTPUT: 15 40
	---FIN ETAT 40 ---------------------------
	
	
	---ETAT 45 -------------------------------
			  when etat45 => 
				bonbon <= '1'; 
				reste <= "100";
				next_state <= etat0;
				 somme <= "1100"; 
					 -- OUTPUT: 20 45
	---FIN ETAT 45 ---------------------------
	
	--CAS PAS POSSIBLES
			 when others =>
				next_state <= etat0;
				somme <= "0000"; 
				reste <= "000"; 
	-----------------------------------------------

end case;
end process;
end synth;
