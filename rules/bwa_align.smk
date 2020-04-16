rule bwa_align:
    input:
        ref_fasta=config["ref"]["fasta"],
        fq1="{Path}/data/samples/{sample}_R1.fastq.gz",
	fq2="{Path}/data/samples/{sample}_R2.fastq.gz"
    output:
        "{Path}/mapped_reads/{sample}.sort.bam"
    params:
        rg=r"@RG\tID:{sample}\tLB:{sample}\tSM:{Path}/{sample}.sort.dup.bqsr.bam\tPL:ILLUMINA"
    threads: 48
    run:
        if len(single_end_samples)>0:
            shell("bwa mem -R '{params.rg}' {input.ref_fasta} {input.fq1} | samtools view -bh - | samtools sort -m 2G - > {output}")
        elif len(paired_end_samples)>0:
            shell("bwa mem -R '{params.rg}' {input.ref_fasta} {input.fq1} {input.fq2} | samtools view -bh - | samtools sort -m 2G - > {output}")
