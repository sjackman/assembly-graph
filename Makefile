k=4

all: sample.asqg sample.dot sample.sam

clean:
	rm -f sample.asqg sample.dot sample.sam

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

%.asqg: %.gfa
	abyss-todot --asqg -k$k $< >$@

%.dot: %.gfa
	abyss-todot --dot -k$k $< >$@

%.sam: %.gfa
	abyss-todot --sam -k$k $< >$@

%.bam: %.sam
	samtools view -Su $< |samtools sort - $*

%.bam.bai: %.bam
	samtools index $<
