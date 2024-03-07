mod Return {

    pub type alias Poly = Option[String]

    pub eff Return {
        pub def return(res: Poly): Void
    }

    pub def withReturn(f: a -> Poly \ Return + ef): a -> Poly \ ef = x -> {
        try f(x) with Return {
            def return(res, _k) = res
        }
    }

    pub def example(): Option[String] = withReturn(_ -> {
        let input = "hello";
        let firstLetter = match String.nth(0, input) {
            case None => do Return.return(None)
            case Some(v) if String.isAscii(Char.toString(v)) => v
            case Some(_) => do Return.return(None)
        };
        Some("Hello ${firstLetter}...")
    })()


}
