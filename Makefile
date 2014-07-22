ALL=sample.asqg sample.dot sample.sam \
	sample.dot.png \
	sample.fa sample.fa.fai \
	sample.bam sample.bam.bai \
	loop.asqg loop.dot loop.sam loop.fa loop.fa.fai loop.dot.png

all: $(ALL)

clean:
	rm -f $(ALL)

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

%.fa: %.gfa
	awk '$$1 == "S" { print ">" $$2 "\n" $$3 }' $< >$@

%.fa.fai: %.fa
	samtools faidx $<
