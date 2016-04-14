OBJ=rel_comms_gobp	rel_comms_gocc	rel_comms_gomf	rel_comms_kegg

all:VN:	$OBJ

rel_comms_kegg:	RESULTADOS_RESUMIDOS_.tsv
	./columnator -v search=4 RESULTADOS_RESUMIDOS_.tsv > rel_comms_kegg

rel_comms_gobp:	RESULTADOS_RESUMIDOS_.tsv
	./columnator -v search=5 RESULTADOS_RESUMIDOS_.tsv > rel_comms_gobp

rel_comms_gocc:	RESULTADOS_RESUMIDOS_.tsv
	./columnator -v search=6 RESULTADOS_RESUMIDOS_.tsv > rel_comms_gocc

rel_comms_gomf:	RESULTADOS_RESUMIDOS_.tsv
	./columnator -v search=7 RESULTADOS_RESUMIDOS_.tsv > rel_comms_gomf

%/:
	mkdir -p $stem

test:V: test/
	./columnator -v search=4 test/juguete.tsv > test/juguete_kegg.run
	./columnator -v search=5 test/juguete.tsv > test/juguete_gobp.run
	./columnator -v search=6 test/juguete.tsv > test/juguete_gocc.run
	./columnator -v search=7 test/juguete.tsv > test/juguete_gomf.run
	diff test/juguete_kegg.tsv test/juguete_kegg.run
	diff test/juguete_gobp.tsv test/juguete_gobp.run
	diff test/juguete_gocc.tsv test/juguete_gocc.run
	diff test/juguete_gomf.tsv test/juguete_gomf.run

clean:V:
	rm $OBJ *.run
