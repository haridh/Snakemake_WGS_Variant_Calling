rule Mutect:
    input:
        ref_fasta=config["ref"]["fasta"],
        plusbam="{Path}/BQSR/{basename}_plus.sort.dup.bqsr.bam",
        minusbam="{Path}/BQSR/{basename}_minus.sort.dup.bqsr.bam"
    output:
        mutect="{Path}/Mutect/{basename}.mutect.vcf"
    threads: 48
    run:
        shell ("gatk Mutect2 --input {input.plusbam} --input {input.minusbam} -normal {input.minusbam} --output {output.mutect} -reference {input.ref_fasta}")
	shell ("mkdir {Path}/Lofreq")
        shell ("lofreq somatic -n {input.minusbam} -t {input.plusbam} -f {input.ref_fasta} -o {Path}/Lofreq/{basename}.lofreq")
