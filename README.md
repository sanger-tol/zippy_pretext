[![GitHub Actions CI Status](https://github.com/sanger-tol/zippypretext/actions/workflows/ci.yml/badge.svg)](https://github.com/sanger-tol/zippypretext/actions/workflows/ci.yml)
[![GitHub Actions Linting Status](https://github.com/sanger-tol/zippypretext/actions/workflows/linting.yml/badge.svg)](https://github.com/sanger-tol/zippypretext/actions/workflows/linting.yml)[![Cite with Zenodo](http://img.shields.io/badge/DOI-10.5281/zenodo.XXXXXXX-1073c8?labelColor=000000)](https://doi.org/10.5281/zenodo.XXXXXXX)
[![nf-test](https://img.shields.io/badge/unit_tests-nf--test-337ab7.svg)](https://www.nf-test.com)

[![Nextflow](https://img.shields.io/badge/nextflow%20DSL2-%E2%89%A523.04.0-23aa62.svg)](https://www.nextflow.io/)
[![run with conda](http://img.shields.io/badge/run%20with-conda-3EB049?labelColor=000000&logo=anaconda)](https://docs.conda.io/en/latest/)
[![run with docker](https://img.shields.io/badge/run%20with-docker-0db7ed?labelColor=000000&logo=docker)](https://www.docker.com/)
[![run with singularity](https://img.shields.io/badge/run%20with-singularity-1d355c.svg?labelColor=000000)](https://sylabs.io/docs/)
[![Launch on Seqera Platform](https://img.shields.io/badge/Launch%20%F0%9F%9A%80-Seqera%20Platform-%234256e7)](https://cloud.seqera.io/launch?pipeline=https://github.com/sanger-tol/zippypretext)

## Introduction

**sanger-tol/zippypretext** is a bioinformatics pipeline typically used to generate pretext maps while avoiding the computationally expensive remapping steps associated with tools like BWA or Minimap, as long as the required arguments are provided. ZippyPretext is particularly beneficial when working with large genomes, offering significant advantages in terms of efficiency and convenience.

- Time-saving for curation: ZippyPretext is ideal for quickly checking curation work without the need to perform time-consuming remapping. This allows researchers to review results and make adjustments more rapidly, saving valuable computational resources and time.

- Efficiency with large genomes: It is particularly well-suited for large genomes, especially those with scaffolds larger than 2GB. Traditional pipelines often require re-splitting large scaffolds for remapping, but ZippyPretext handles the scaling of pretext maps directly, eliminating the need for this extra step. This makes it an efficient choice for working with genomes that are difficult to manage using standard mapping approaches.

Additionally, ZippyPretext’s scalability and streamlined workflow make it an ideal tool for generating pretext maps in projects like the Tree of Life, where large datasets and complex genomic structures are common. Overall, the pipeline enhances productivity by reducing both time and resource consumption while maintaining accuracy and reliability.

## Usage

> [!NOTE]
> If you are new to Nextflow and nf-core, please refer to [this page](https://nf-co.re/docs/usage/installation) on how to set-up Nextflow. Make sure to [test your setup](https://nf-co.re/docs/usage/introduction#how-to-run-a-pipeline) with `-profile test` before running the workflow on actual data.

The pipeline requires a set of arguments.

- `--fasta`
   - The fasta file before curation, e.g., `/path/to/assembly_before_curation.fa`
   - 
- `--idxfile`
   - The fasta file index file before curation, e.g., `/path/to/assembly_before_curation.fa.fai`
     
- `--sample`
   - Output pretext map name, e.g., `assembly_after_curation`
 
- `--agp`
   - Curated AGP file output from PretextMap, e.g., `/path/to/curated.agp`

- `--hicmap`
  - Alignment bin file before curation,  e.g., `/path/to/assembly_before_curation.bin`
-->

Now, you can run the pipeline using:

<!-- TODO nf-core: update the following command to include all required parameters for a minimal example -->

```bash
nextflow run sanger-tol/zippypretext \
   -profile <docker/singularity/.../institute> \
   --fasta { /path/to/assembly_before_curation.fa } \
   --idxfile { /path/to/assembly_before_curation.fa.fai } \
   --sample { assembly_after_curation } \
   --agp { /path/to/curated.agp } \
   --hicmap { /path/to/assembly_before_curation.bin } \
   --outdir { OUTDIR }
```

> [!WARNING]
> Please provide pipeline parameters via the CLI or Nextflow `-params-file` option. Custom config files including those provided by the `-c` Nextflow option can be used to provide any configuration _**except for parameters**_;
> see [docs](https://nf-co.re/usage/configuration#custom-configuration-files).

## Credits

sanger-tol/zippypretext was originally written by Yumi Sims.

We thank the following people for their extensive assistance in the development of this pipeline:

- @c-zhou - Algothrithm 
- @weaglesBio - For reviews.

## Contributions and Support

If you would like to contribute to this pipeline, please see the [contributing guidelines](.github/CONTRIBUTING.md).

## Citations

An extensive list of references for the tools used by the pipeline can be found in the [`CITATIONS.md`](CITATIONS.md) file.

This pipeline uses code and infrastructure developed and maintained by the [nf-core](https://nf-co.re) community, reused here under the [MIT license](https://github.com/nf-core/tools/blob/master/LICENSE).

> **The nf-core framework for community-curated bioinformatics pipelines.**
>
> Philip Ewels, Alexander Peltzer, Sven Fillinger, Harshil Patel, Johannes Alneberg, Andreas Wilm, Maxime Ulysse Garcia, Paolo Di Tommaso & Sven Nahnsen.
>
> _Nat Biotechnol._ 2020 Feb 13. doi: [10.1038/s41587-020-0439-x](https://dx.doi.org/10.1038/s41587-020-0439-x).
