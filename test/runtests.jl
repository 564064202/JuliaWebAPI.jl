using JuliaWebAPI
using Logging
using Base.Test
using Compat

const opts = Base.JLOptions()
const inline_flag = opts.can_inline == 1 ? `` : `--inline=no`
const cov_flag = (opts.code_coverage == 1) ? `--code-coverage=user` :
                 (opts.code_coverage == 2) ? `--code-coverage=all` :
                 ``

function run_test(script, flags)
    srvrscript = joinpath(dirname(@__FILE__), script)
    srvrcmd = `$(joinpath(JULIA_HOME, "julia")) $cov_flag $inline_flag $script $flags`
    println("RUNNING TESTS: ", script, "\n", "="^60)
    run(srvrcmd)
    println("FINISHED TESTS: ", script, "\n", "="^60)
    nothing
end

run_test("test_asyncsrvr.jl", "--runasyncsrvr")
run_test("test_clntsrvr.jl", "--runclntsrvr")
run_test("test_remotecall.jl", "--runremotecall")
