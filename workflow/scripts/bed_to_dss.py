#!/usr/bin/env python3
import argparse
import pandas as pd

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("inp", help="modkit pileup bed.gz (bgzipped bedMethyl)")
    ap.add_argument("out", help="output DSS tsv")
    ap.add_argument("--mod-code", default="m", help="modkit mod code to keep (e.g. m for 5mC)")
    args = ap.parse_args()

    df = pd.read_csv(args.inp, sep="\t", header=None, comment="#", compression="infer")
    if df.shape[1] < 11:
        raise SystemExit(f"Unexpected bedMethyl: got {df.shape[1]} cols, expected >= 11.")

    chrom  = df.iloc[:, 0].astype(str)
    start0 = df.iloc[:, 1].astype(int)
    code   = df.iloc[:, 3].astype(str)

    Nvalid = pd.to_numeric(df.iloc[:, 9], errors="coerce").fillna(0).astype(int)
    frac   = pd.to_numeric(df.iloc[:,10], errors="coerce").fillna(0.0).astype(float)

    keep = (code == args.mod_code)
    chrom  = chrom[keep]
    start0 = start0[keep]
    Nvalid = Nvalid[keep]
    frac   = frac[keep]

    pos1 = start0 + 1
    X = (Nvalid * frac).round().astype(int)

    out_df = pd.DataFrame({"chr": chrom.values, "pos": pos1.values, "N": Nvalid.values, "X": X.values})
    out_df.to_csv(args.out, sep="\t", index=False)

if __name__ == "__main__":
    main()
