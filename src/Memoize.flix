mod Memoize {

    pub def memoize(rc: Region[r], f: a -> b \ ef): (a -> b \ ef + r) \ r with Order[a] = {
        let m = MutMap.new(rc);
        def g(x) = {
            match MutMap.get(x, m) {
                case None => {
                    let result = f(x);
                    MutMap.put!(x, result, m);
                    result
                }
                case Some(result) =>
                    result
            }
        };
        g
    }


    def fib(n: Int32): Int32 = {
        if (debug!!(n) == 0) 1
        else if (n == 1) 1
        else fib(n-1) + fib(n-2)
    }

    @Test
    pub def example(): Unit \ IO = region local {
        // doesn't work for recursive functions
        memoize(local, fib)(10) |> println
    }

}
