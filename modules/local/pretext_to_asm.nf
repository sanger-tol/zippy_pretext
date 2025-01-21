process PRETEXT_TO_ASM {
    tag "$meta.id"
    label 'process_single'

    container 'ghcr.io/sanger-tol/agp-tpf-utils:1.1.3'

    input:
    tuple val(meta), path(mappedfasta)
    path(pretextagp)


    output:
    tuple val(meta), path("*agp")  , emit: correctedagp
    path "versions.yml"            , emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args    = task.ext.args     ?: ''
    def prefix  = task.ext.prefix   ?: "${meta.id}"

    """
    pretext-to-asm -a ${mappedfasta} -p ${pretextagp} -o ${prefix}_corrected.agp ${args}
    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        agp-tpf-utils: \$(agp-tpf-utils --version | sed 's/agp-tpf-utils //g')
    END_VERSIONS
    """

    stub:
    def prefix  = args.ext.prefix   ?: "${meta.id}"
    """
    touch ${prefix}.agp

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        agp-tpf-utils: \$(agp-tpf-utils --version | sed 's/agp-tpf-utils //g')
    END_VERSIONS
    """
}
