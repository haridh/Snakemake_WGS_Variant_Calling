rule Mark_duplicates:
    input:
        inbam="{Path}/mapped_reads/{sample}.sort.bam"
    output:
        outbam="{Path}/mapped_reads/{sample}.sort.dup.bam",
        metrics="{Path}/{sample}.dup.metrics.txt"
    threads: 48
    shell:
        "picard MarkDuplicates I={input.inbam} O={output.outbam} M={output.metrics}"
