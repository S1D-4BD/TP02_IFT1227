library IEEE; use IEEE.STD_LOGIC_1164.ALL;

entity fsm_moore is
	Port (
		clk: in  STD_LOGIC;  -- Clock (jai programme pour la switch F15
      reset : in  STD_LOGIC;  -- Reset (jai programme pour la switch B14)
      m5: in  STD_LOGIC;  -- 5 cents (la switch C10)
      m10: in  STD_LOGIC;  -- 10 cents (la switch C11)
      m25: in  STD_LOGIC;  -- 25 cents (la switch D12)

       
      HEX00: out STD_LOGIC;
      HEX01: out STD_LOGIC;
      HEX02: out STD_LOGIC;
      HEX03: out STD_LOGIC;
      HEX04: out STD_LOGIC;
      HEX05: out STD_LOGIC;
      HEX06: out STD_LOGIC;
      HEX10: out STD_LOGIC;
      HEX11: out STD_LOGIC;
      HEX12: out STD_LOGIC;
      HEX13: out STD_LOGIC;
      HEX14: out STD_LOGIC;
      HEX15: out STD_LOGIC;
      HEX16      : out STD_LOGIC;
		  
--ca va etre pour l'affichage de la monnaie a rendre

      HEX30: out STD_LOGIC;
      HEX31: out STD_LOGIC;
      HEX32: out STD_LOGIC;
      HEX33: out STD_LOGIC;
      HEX34: out STD_LOGIC;
      HEX35: out STD_LOGIC;
      HEX36: out STD_LOGIC;

      HEX40: out STD_LOGIC;
      HEX41: out STD_LOGIC;
      HEX42: out STD_LOGIC;
      HEX43: out STD_LOGIC;
      HEX44: out STD_LOGIC;
      HEX45: out STD_LOGIC;
      HEX46: out STD_LOGIC;

      bonbon  : out STD_LOGIC -- led pr debug le cas sup. à 25
    );
end fsm_moore;

architecture synth of fsm_moore is

    
	signal somme : STD_LOGIC_VECTOR(3 downto 0); -- 4 bits pour la somme (la plus grosse somme quon peut faire c'est 45)
	signal resteRemis : STD_LOGIC_VECTOR(2 downto 0); -- 3 bits pour la monnaie rendue (le plus de monnaie quon remet c'Est 20)

begin

    
   fsm_controller_inst : entity work.controller
      port map (
			clk => clk,
         reset => reset,
         in5 => m5,        								-- je mets 5 cents
         in10 => m10,       								-- je mets 10 cents
         in25 => m25,       								-- je mets 25 cents
         somme => somme,  								-- Bus somme  (va dans les 2 premiers afficheur)
         reste => resteRemis, 						-- Bus  DE monnaie a rendre (va ds les 2 derniers afficheurs)
         bonbon => bonbon 								-- Signal pr moi (a chaque 25 et + ca va s'allumer)
   );

afficheur_somme : entity work.segment_controller     --donc les switches vont dans le bus de somme monnaie 
		port map (                                       --(!!! la switch des 20 cents marche pas ca existe pas, 
         SW3 => somme(3), 										-- mais on doit quand meme etre capable d'afficher 20 cents si jamais on fait 10 +10)
         SW2 => somme(2),
         SW1 => somme(1),
         SW0 => somme(0),

         HEX00 => HEX00, 
         HEX01 => HEX01,
         HEX02 => HEX02,
         HEX03 => HEX03,
         HEX04 => HEX04,
         HEX05 => HEX05,
         HEX06 => HEX06,

         HEX10 => HEX10,
         HEX11 => HEX11,
         HEX12 => HEX12,
         HEX13 => HEX13,
         HEX14 => HEX14,
         HEX15 => HEX15,
         HEX16 => HEX16
   );

  
      afficheur_reste : entity work.segment_controller --la on va instancier mon segment controller ;)
      port map (
			SW3 => '0',           -- Pas de pièce de 25 cents a remettre (on a anyways pas d'etat 50 cents on va jamais l'afficher)
         SW2 => resteRemis(2),  -- pour afficher 20 cents
         SW1 => resteRemis(1), -- pour afficher 10 cens
         SW0 => resteRemis(0), -- pour 5 cents

         HEX00 => HEX30,		 --je sais j'ai appelé aussi mes inputs du 7seg par leur signal dans le DE-10, mais c'est plus facile pour moi de le représenter comme ca, je sais que hex 35 c'est le 5ieme led T_T
         HEX01 => HEX31,
         HEX02 => HEX32,
         HEX03 => HEX33,
         HEX04 => HEX34,
         HEX05 => HEX35,
         HEX06 => HEX36,

         HEX10 => HEX40,
         HEX11 => HEX41,
         HEX12 => HEX42,
         HEX13 => HEX43,
         HEX14 => HEX44,
         HEX15 => HEX45,
         HEX16 => HEX46
   );

end synth;
