ALL=sample.asqg sample.gv sample.sam \
	sample.gv.png \
	sample.fa sample.fa.fai \
	sample.bam sample.bam.bai \
	loop.asqg loop.gv loop.sam loop.fa loop.fa.fai loop.gv.png

all: $(ALL)

clean:
	rm -f $(ALL)

.PHONY: all clean
.DELETE_ON_ERROR:
.SECONDARY:

%.asqg: %.gfa
	abyss-todot --asqg $< >$@

%.gv: %.gfa
	abyss-todot --gv $< >$@

%.sam: %.gfa
	abyss-todot --sam $< >$@

%.bam: %.sam
	samtools view -Su $< |samtools sort - $*

%.bam.bai: %.bam
	samtools index $<

%.gv.png: %.gv
	dot -Tpng $< >$@

%.fa: %.gfa
	awk '$$1 == "S" { print ">" $$2 "\n" $$3 }' $< >$@

%.fa.fai: %.fa
	samtools faidx $<
