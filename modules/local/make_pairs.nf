process MAKE_PAIRS {
    tag "$meta.id"
    label 'process_single'

    conda "conda-forge::coreutils=9.1"
    container "${ workflow.containerEngine == 'singularity' && !task.ext.singularity_pull_docker_container ?
    'https://depot.galaxyproject.org/singularity/ubuntu:20.04' :
    'docker.io/ubuntu:20.04' }"

    input:
    tuple val(meta), path(alignment)
    path(header)

    output:
    tuple val(meta), path("*pairs.gz")  , emit: pairs
    path "versions.yml"                 , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args    = task.ext.args     ?: ''
    def prefix  = task.ext.prefix   ?: "${meta.id}"

    """
    makepairs.sh ${header} ${alignment} > ${prefix}_alignment.pairs.gz
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        makepairs: \$(makepairs.sh -v)
    END_VERSIONS
    """

    stub:
    def prefix  = args.ext.prefix   ?: "${meta.id}"
    """
    touch ${prefix}.pairs.gz

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        makepairs: \$(makepairs.sh -v)
    END_VERSIONS
    """
}
