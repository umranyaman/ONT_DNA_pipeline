rule modkit_pileup:
    input:
        bam=os.path.join(OUT_BASE, "bam", "{pool}_{genotype}.bam"),
        bai=os.path.join(OUT_BASE, "bam", "{pool}_{genotype}.bam.bai"),
        ref=REF
    output:
        bedgz=os.path.join(OUT_BASE, "pileup", "{pool}_{genotype}.bed.gz"),
        tbi=os.path.join(OUT_BASE, "pileup", "{pool}_{genotype}.bed.gz.tbi")
    threads: THREADS
    conda:
        "../envs/modkit.yaml"
    params:
        preset=MODKIT_PRESET,
        extra=MODKIT_EXTRA
    shell:
        r"""
        set -euo pipefail
        outdir=$(dirname {output.bedgz})
        mkdir -p "$outdir"
        tmpbed="$outdir/{wildcards.pool}_{wildcards.genotype}.bed"

        modkit pileup {input.bam} "$tmpbed" \
          --ref {input.ref} \
          --threads {threads} \
          --preset {params.preset} \
          {params.extra}

        bgzip -f -@ {threads} -c "$tmpbed" > {output.bedgz}
        tabix -f -p bed {output.bedgz}
        rm -f "$tmpbed"
        """
