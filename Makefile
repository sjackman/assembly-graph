all: sample.asqg sample.dot sample.sam

clean:
	rm -f sample.asqg sample.dot sample.sam

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

%.asqg: %.gfa
	abyss-todot --asqg $< >$@

%.dot: %.gfa
	abyss-todot --dot $< >$@

%.sam: %.gfa
	abyss-todot --sam $< >$@

%.bam: %.sam
	samtools view -Su $< |samtools sort - $*

%.bam.bai: %.bam
	samtools index $<

%.dot.png: %.dot
	dot -Tpng $< >$@
