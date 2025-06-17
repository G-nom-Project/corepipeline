# G-nom-Project/corepipeline

[![GitHub Actions CI Status](https://github.com/G-nom-Project/corepipeline/actions/workflows/ci.yml/badge.svg)](https://github.com/G-nom-Project/corepipeline/actions/workflows/ci.yml)
[![GitHub Actions Linting Status](https://github.com/G-nom-Project/corepipeline/actions/workflows/linting.yml/badge.svg)](https://github.com/G-nom-Project/corepipeline/actions/workflows/linting.yml)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/version-%E2%89%A524.04.2-green?style=flat&logo=nextflow&logoColor=white&color=%230DC09D&link=https%3A%2F%2Fnextflow.io)](https://www.nextflow.io/)
[![nf-core template version](https://img.shields.io/badge/nf--core_template-3.3.1-green?style=flat&logo=nfcore&logoColor=white&color=%2324B064&link=https%3A%2F%2Fnf-co.re)](https://github.com/nf-core/tools/releases/tag/3.3.1)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)

## Introduction

**G-nom-Project/corepipeline** is designed to generate core analyses for new assemblies to be added to G-nom. This includes Repeatmasker, BUSCO (genome + protein) and taXaminer (planned). The output folder can be important instantly using the G-nom API.

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

```
nextflow run G-nom-Project-corepipeline/main.nf \\
   --fasta <path to genomic fasta file> \\
   --rmdb <path to RepeatMasker Libraries> \\
   --species <species name for RepeatMasker> \\
   --outdir <output directory> \\
   --busco_lineage <BUSCO Lineage ID> \\
   --protein_fasta <path to protein fasta file>
```
For BUSCO lineages please refer to the [official list](https://busco.ezlab.org/list_of_lineages.html).



> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_; see [docs](https://nf-co.re/docs/usage/getting_started/configuration#custom-configuration-files).

## Credits

G-nom-Project/corepipeline was originally written by Lucas Koch.

We thank the following people for their assistance in the development of this pipeline:

[Felix Haidle](https://github.com/felixhaidle)

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations

An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/main/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
