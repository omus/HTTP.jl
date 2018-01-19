#using Unitful

using HTTP


#const tunit = u"ms"
#const tmul = Int(1u"s"/1tunit)
#delta_t(a, b) = round((b - a) * tmul, 0)tunit
delta_t(a, b) = round((b - a), 3)

function go(count::Int)

    urls = split(String(read("urls")), '\n')


                                                                t_start = time()
    @time for rep in 1:count
        for url in urls
            uri = HTTP.URIs.http_parser_parse_url(url)
        end
    end
                                                                 t_done = time()
    t1 = delta_t(t_start, t_done)

    if count > 10
        println("http_parser_parse_url parsed $(length(urls)) urls $count times in $t1\n")
    end
                                                                t_start = time()
    @time for rep in 1:count
        for url in urls
            uri = HTTP.URIs.regex_parse(HTTP.URI, url)
        end
    end
                                                                 t_done = time()
    t2 = delta_t(t_start, t_done)

    if count > 10
        println("regex_parse parsed $(length(urls)) urls $count times in $t2 ($(round(100*t2/t1, 1))%)\n")
    end
end

for r in [10, 10000]
    go(r)
    println("")
end
