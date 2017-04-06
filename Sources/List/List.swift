
import liblist

public class List<T> {
	
	internal var list: UnsafeMutablePointer<llist>
	
	public var first: T? {
		guard let firstNode = list_first_node(list) else {
			return nil
		}
		
		return getValueFromNode(firstNode)
	}
	
	public var last: T? {
		guard let lastNode = list_last_node(list) else {
			return nil
		}
		
		return getValueFromNode(lastNode)
	}
	
	public init() {
		list = new_list()
	}
	
	public convenience init<S: Sequence>(_ sequence: S) where S.Iterator.Element == T {
		self.init()
		for e in sequence {
			append(e)
		}
	}
	
	deinit {
		list_free(list)
	}
	
	private func nodeWithValue(_ value: T) -> UnsafeMutablePointer<llnode> {
		let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
		ptr.initialize(to: value)
		let raw = UnsafeMutableRawPointer(ptr)
		
		return node_with_value(raw)
	}
	
	public func prepend(_ value: T) {
		let node = nodeWithValue(value)
		
		list_prepend_node(list, node)
	}
	
	public func append(_ value: T) {
		let node = nodeWithValue(value)
		
		list_append_node(list, node)
	}
	
	@discardableResult
	public func removeFirst() -> T? {
		guard let node = list_remove_first_node(list) else {
			return nil
		}
		
		defer { node_free(node) }
		
		return getValueFromNode(node)
	}
	
	@discardableResult
	public func removeLast() -> T? {
		guard let node = list_remove_last_node(list) else {
			return nil
		}
		
		defer { node_free(node) }
		
		return getValueFromNode(node)
	}
	
	internal func getValueFromNode(_ node: UnsafeMutablePointer<llnode>) -> T {
		guard let raw = node.pointee.data else {
			fatalError("no value found")
		}
		let opq = OpaquePointer(raw)
		let ptr = UnsafeMutablePointer<T>(opq)
		
		return ptr.pointee
	}
	
}

extension List: Sequence {
	
	public func makeIterator() -> ListIterator<T> {
		return ListIterator(self)
	}
	
}

extension List: CustomStringConvertible {
	
	public var description: String {
		var str = "\(type(of: self))"
		str += "{" + map { "\($0)" }.joined(separator: ", ") + "}"
		return str
	}
	
}

public struct ListIterator<T>: IteratorProtocol {
	
	private var list: List<T>
	
	private var node: UnsafeMutablePointer<llnode>?
	
	public init(_ list: List<T>) {
		self.list = list
		self.node = list_first_node(list.list)
	}
	
	public mutating func next() -> T? {
		if let node = node {
			defer {
				self.node = list_next_node_after_node(list.list, node)
			}
			
			return list.getValueFromNode(node)
		} else {
			return nil
		}
	}
	
}
