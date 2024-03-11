mod Struct {
    pub type alias NodeRecord[t: Type, r: Region] = {
        data = Ref[t, r],
        // mut data = t,
        prev = Ref[Option[Node[t, r]], r],
        next = Ref[Option[Node[t, r]], r]
    }

    pub enum Node[t: Type, r: Region](NodeRecord[t, r])

    pub def getNext(node: Node[t, r]): Option[Node[t, r]] \ r = {
        let Node.Node(rec) = node;
        deref rec.next
    }
    pub def setNext(x: Option[Node[t, r]], node: Node[t, r]): Unit \ r = {
        let Node.Node(rec) = node;
        rec.next := x
    }
    // etc ...
}
