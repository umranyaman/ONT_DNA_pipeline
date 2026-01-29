rule bed_to_dss:
    input:
        bedgz=os.path.join(OUT_BASE, "pileup", "{pool}_{genotype}.bed.gz")
    output:
        dss=os.path.join(OUT_BASE, "DSS", f"{MOD_TYPE}.{{pool}}_{{genotype}}.dss.tsv")
    conda:
        "../envs/bed_to_dss.yaml"
    params:
        mod_code=MOD_CODE
    shell:
        r"""
        set -euo pipefail
        mkdir -p $(dirname {output.dss})
        python scripts/bed_to_dss.py {input.bedgz} {output.dss} --mod-code {params.mod_code}
        """
