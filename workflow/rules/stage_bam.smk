rule stage_bam:
    input:
        bam=in_bam,
        bai=in_bai
    output:
        bam=os.path.join(OUT_BASE, "bam", "{pool}_{genotype}.bam"),
        bai=os.path.join(OUT_BASE, "bam", "{pool}_{genotype}.bam.bai")
    shell:
        r"""
        set -euo pipefail
        mkdir -p $(dirname {output.bam})
        ln -sf "$(realpath {input.bam})" {output.bam}
        ln -sf "$(realpath {input.bai})" {output.bai}
        """
