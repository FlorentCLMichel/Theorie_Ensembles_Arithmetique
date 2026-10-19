FILES_TEEA = \
	Ensembles_Arithmetique.tex\
	Ensembles_Arithmetique/Preamble.tex\
	Ensembles_Arithmetique/Titlepage.tex\
	Ensembles_Arithmetique/Theorie_Ensembles.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Logique_premier_ordre.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Theorie_ZFC.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Notations_Resultats.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Construction_N.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Construction_Z.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Cardinal.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Theorie_groupes.tex\
	Ensembles_Arithmetique/Theorie_Ensembles/Polynomes.tex\
	Ensembles_Arithmetique/Arithmetique.tex\
	Ensembles_Arithmetique/Arithmetique/Division_Euclidienne.tex\
	Ensembles_Arithmetique/Arithmetique/Base.tex\
	Ensembles_Arithmetique/Arithmetique/Nombres_Premiers.tex\
	Ensembles_Arithmetique/Arithmetique/Groupes.tex\
	Ensembles_Arithmetique/Arithmetique/Groupe_ZnZ.tex\
	Ensembles_Arithmetique/Autres_Structures_Nombres.tex\
	Ensembles_Arithmetique/Autres_Structures_Nombres/Rationnels.tex\
	Ensembles_Arithmetique/Autres_Structures_Nombres/Reels.tex\
	Ensembles_Arithmetique/Autres_Structures_Nombres/Complexes.tex\
	Ensembles_Arithmetique/Autres_Structures_Nombres/Topologie.tex\
	Ensembles_Arithmetique/Jeux_Entiers.tex\
	Ensembles_Arithmetique/Codes.tex\
	Ensembles_Arithmetique/Code/base.hs\
	Ensembles_Arithmetique/Code/isPrime.hs\
	Ensembles_Arithmetique/Code/is_prime.c\
	Ensembles_Arithmetique/Code/is_prime.rs\
	Ensembles_Arithmetique/Code/pgcd.hs\
	Ensembles_Arithmetique/Code/pgcd.c\
	Ensembles_Arithmetique/Code/pgcd.rs\
	Ensembles_Arithmetique/Code/Erastosthene.cpp\
	Ensembles_Arithmetique/Code/Erastosthene.rs\
	Ensembles_Arithmetique/Code/Erastosthene_lib.rs\
	Ensembles_Arithmetique/Code/FindNPrimes.hs\
	Ensembles_Arithmetique/Code/output_decomposition_prime_factors.tex\
	Ensembles_Arithmetique/Code/first_primes.dat\
	Ensembles_Arithmetique/Resources/buff-imp-cpp.lua\
	Ensembles_Arithmetique/Resources/buff-imp-cpp.mkiv\
	Ensembles_Arithmetique/Resources/buff-imp-haskell.lua\
	Ensembles_Arithmetique/Resources/buff-imp-haskell.mkiv\
	Ensembles_Arithmetique/Resources/buff-imp-rust.lua\
	Ensembles_Arithmetique/Resources/buff-imp-rust.mkiv\
	Ensembles_Arithmetique/Resources/style.css\
	Ensembles_Arithmetique/Resources/firstpage.png\

Ensembles_Arithmetique.pdf: $(FILES_TEEA) 
	TEXMF=$(LMTX) context Ensembles_Arithmetique.tex

Ensembles_Arithmetique-export: $(FILES_TEEA)
	TEXMF=$(LMTX) mtxrun --script epub --images Ensembles_Arithmetique.tex --mode=export
	TEXMF=$(LMTX) context --mode=export Ensembles_Arithmetique.tex
    
Ensembles_Arithmetique/Code/output_decomposition_prime_factors.tex:\
	Ensembles_Arithmetique/Code/decomposition_prime_factors.rs\
	Ensembles_Arithmetique/Code/Érastosthène.rs
	cd Ensembles_Arithmetique/Code \
		&& $(RUST) decomposition_prime_factors.rs \
		&& ./decomposition_prime_factors \
    
Ensembles_Arithmetique/Code/first_primes.dat:\
	Ensembles_Arithmetique/Code/first_primes.cpp\
	Ensembles_Arithmetique/Code/Érastosthène.cpp
	cd Ensembles_Arithmetique/Code \
		&& $(CXX) first_primes.cpp -I. -o first_primes \
		&& ./first_primes

TO_CLEAN += \
	Ensembles_Arithmetique.log\
	Ensembles_Arithmetique.tuc\
	Ensembles_Arithmetique.pgf\
	Ensembles_Arithmetique.tua\
	Ensembles_Arithmetique-t-b-*.pdf\
	Ensembles_Arithmetique-t-b-*.log\
	Ensembles_Arithmetique/Code/decomposition_prime_factors\
	Ensembles_Arithmetique/Code/first_primes\
	Ensembles_Arithmetique-export\
	Ensembles_Arithmetique-images.*
