process RAPID_SPLIT {
    tag "$meta.id"
    label 'process_single'

    conda "bioconda::biopython=1.70"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
        'https://depot.galaxyproject.org/singularity/biopython:1.70--np112py35_1':
        'quay.io/biocontainers/biopython:1.70--np112py35_1' }"

    input:
    tuple val(meta), path(fasta)

    output:
    tuple val(meta), path("*tpf")  , emit: assigned_bed
    path "versions.yml"            , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args    = task.ext.args     ?: ''
    def prefix  = task.ext.prefix   ?: "${meta.id}"

    """
    rapid_split.py ${fasta} > ${prefix}.tpf ${args}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        python: \$(python --version | sed 's/Python //g')
        rapid_split.py: \$(rapid_split.py --version | cut -d' ' -f2)
    END_VERSIONS
    """

    stub:
    def prefix  = args.ext.prefix   ?: "${meta.id}"
    """
    touch ${prefix}.tpf

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        python: \$(python --version | sed 's/Python //g')
        rapid_split.py: \$(rapid_split.py --version | cut -d' ' -f2)
    END_VERSIONS
    """
}
