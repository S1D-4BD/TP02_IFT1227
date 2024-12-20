 

library IEEE;use IEEE.STD_LOGIC_1164.ALL;

--jai pris les noms de signaux donne dans le guide DE-10 (ca me facilite la vie pour le port mapping de la top-entity

entity segment_controller is
   Port ( SW3 : in STD_LOGIC;   
         SW2 : in STD_LOGIC;   
         SW1 : in STD_LOGIC;   
         SW0 : in STD_LOGIC;   
			  
         HEX00 : out STD_LOGIC;
         HEX01 : out STD_LOGIC;
         HEX02 : out STD_LOGIC;
         HEX03 : out STD_LOGIC;
         HEX04 : out STD_LOGIC;
         HEX05 : out STD_LOGIC;
         HEX06 : out STD_LOGIC;
      --pour l autre afficheur
         HEX10 : out STD_LOGIC;
         HEX11 : out STD_LOGIC;
         HEX12 : out STD_LOGIC;
         HEX13 : out STD_LOGIC;
         HEX14 : out STD_LOGIC;
         HEX15 : out STD_LOGIC;
         HEX16 : out STD_LOGIC);
end segment_controller;

architecture synth of segment_controller is
begin

--sop pour l affichage de chiffres

	HEX00 <= '0';
	HEX01 <= SW3 xor SW0;
	HEX02 <= '0';
	HEX03 <= '0';
	HEX04 <= SW3 xor SW0;
	HEX05 <= '0';
	HEX06 <= not (SW3 xor SW0); 
   HEX10 <= (not SW3 and not SW2 and SW1) or 
            (SW3 and SW2 and not SW1 and not SW0) or 
            (not SW2 and SW1 and SW0);
   HEX11 <= (SW3 and SW2 and SW0) or (SW3 and SW2 and SW1);
   HEX12 <= (not SW3 and SW2 and not SW1) or 
            (SW3 and not SW2 and not SW1 and not SW0);

   HEX13 <= (not SW3 and not SW2 and SW1) or 
            (SW3 and SW2 and not SW1 and not SW0) or 
            (not SW2 and SW1 and SW0);
   HEX14 <= (not SW3 and SW1) or 
            ( SW1 and not SW0) or 
            (SW3 and SW2 and not SW1) or 
            ( SW3 and not SW2 and SW0);

   HEX15 <= (not SW3 and SW1) or 
            (not SW3 and SW2) or 
            (SW3 and not SW2 and not SW1) or 
            (SW3 and not SW2 and not SW0);
      HEX16 <= (not SW3 and not SW2);

end synth;
