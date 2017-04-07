
#include <stdlib.h>
#include <stdio.h>

struct llnode {
	void *data;
	struct llnode *next;
	struct llnode *prev;
};

typedef struct llnode llnode;

typedef struct {
	struct llnode *head;
	size_t count;
} llist;

llnode *node_with_value(void *value){
	llnode *node = calloc(1, sizeof(*node));
	
	node->data = value;
	
	return node;
}

llist *new_empty_list() {
	llnode *head = node_with_value(NULL);
	head->prev = head;
	head->next = head;
	
	llist *li = calloc(1, sizeof(*li));
	li->head = head;
	
	return li;
}

llnode *list_first_node(llist *list) {
	llnode *node = list->head->next;
	
	if (node != list->head) {
		return node;
	}
	
	return NULL;
}

llnode *list_last_node(llist *list) {
	llnode *node = list->head->prev;
	
	if (node != list->head) {
		return node;
	}
	
	return NULL;
}

void list_prepend_node(llist *list, llnode *node);

void list_append_node(llist *list, llnode *node);

llnode *list_remove_first_node(llist *list);

llnode *list_remove_last_node(llist *list);

llnode *list_next_node_after_node(llist *list, llnode *node) {
	llnode *next = node->next;
	
	if (next == list->head) {
		return NULL;
	}
	
	return next;
}

llnode *list_prev_node_before_node(llist *list, llnode *node) {
	llnode *prev = node->prev;
	
	if (prev == list->head) {
		return NULL;
	}
	
	return prev;
}

void list_iterate_forward(llist *list, void (*callback)(llnode*)) {
	llnode * currNode = list->head->next;
	
	while (currNode != list->head) {
		llnode *next = currNode->next;
		
		(*callback)(currNode);
		
		currNode = next;
	}
}

void list_iterate_backward(llist *list, void (*callback)(llnode*)) {
	llnode * currNode = list->head->prev;
	
	while (currNode != list->head) {
		llnode *prev = currNode->prev;
		
		(*callback)(currNode);
		
		currNode = prev;
	}
}

void node_free(llnode *node) {
	free(node->data);
	
	free(node);
}

void list_free(llist *list) {
	list_iterate_backward(list, node_free);
	
	free(list->head);
	
	free(list);
}
