
public class Stack<T> {
	
	let list: List<T>
	
	public init() {
		self.list = List<T>()
	}
	
	public init<S: Sequence>(_ s: S) where S.Iterator.Element == T {
		self.list = List<T>(s)
	}
	
	public func push(_ element: T) {
		list.append(element)
	}
	
	public func peek() -> T? {
		return list.last
	}
	
	@discardableResult
	public func pop() -> T? {
		return list.removeLast()
	}
	
}

extension Stack {
	
	public var count: Int {
		return list.count
	}
	
	public var isEmpty: Bool {
		return list.isEmpty
	}
	
}
