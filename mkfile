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
	./columnator -v search=4 juguete.tsv > juguete_kegg.run
	./columnator -v search=5 juguete.tsv > juguete_gobp.run
	./columnator -v search=6 juguete.tsv > juguete_gocc.run
	./columnator -v search=7 juguete.tsv > juguete_gomf.run
	diff juguete_kegg.tsv juguete_kegg.run
	diff juguete_gobp.tsv juguete_gobp.run
	diff juguete_gocc.tsv juguete_gocc.run
	diff juguete_gomf.tsv juguete_gomf.run

clean:V:
	rm $OBJ *.run
