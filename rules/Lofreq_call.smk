rule Lofreq:
    input:
        ref_fasta=config["ref"]["fasta"],
        plusbam="{Path}/BQSR/{basename}_plus.sort.dup.bqsr.bam",
        minusbam="{Path}/BQSR/{basename}_minus.sort.dup.bqsr.bam"
    output:
        Lofreq="{Path}/Lofreq/{basename}/lofreq_somatic_final.snvs.vcf.gz"
    threads: 48
    run:
        for file in basename:
          shell ("mkdir -p {Path}/Lofreq/{file}")
        shell ("lofreq somatic -n {input.minusbam} -t {input.plusbam} -f {input.ref_fasta} -o {Path}/Lofreq/{file}/lofreq_ 2> {Path}/Lofreq/Lofreq_log.txt")
