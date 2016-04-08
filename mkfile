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

clean:V:
	rm $OBJ
