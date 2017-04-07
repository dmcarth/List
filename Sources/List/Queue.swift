
public class Queue<T> {
	
	let list: List<T>
	
	public init() {
		self.list = List<T>()
	}
	
	public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
		self.list = List<T>(s)
	}
	
	public func enqueue(_ element: T) {
		list.append(element)
	}
	
	@discardableResult
	public func dequeue() -> T? {
		return list.removeFirst()
	}
	
}

extension Queue {
	
	public var count: Int {
		return list.count
	}
	
	public var isEmpty: Bool {
		return list.isEmpty
	}
	
}
