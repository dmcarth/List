
#include "liblist.h"

void list_insert_node(llist *list, llnode *node, llnode *prev, llnode *next) {
	prev->next = node;
	node->prev = prev;
	node->next = next;
	next->prev = node;
	
	list->count++;
}

void list_prepend_node(llist *list, llnode *node) {
	list_insert_node(list, node, list->head, list->head->next);
}

void list_append_node(llist *list, llnode *node) {
	list_insert_node(list, node, list->head->prev, list->head);
}

int list_can_remove_node(llist *list, llnode *node) {
	if (node == list->head) {
		return 0;
	} else {
		return 1;
	}
}

llnode *list_remove_node(llist *list, llnode *node) {
	if (list_can_remove_node(list, node)) {
		node->prev->next = node->next;
		
		list->count--;
		
		return node;
	} else {
		return NULL;
	}
}

llnode *list_remove_first_node(llist *list) {
	return list_remove_node(list, list->head->next);
}

llnode *list_remove_last_node(llist *list) {
	return list_remove_node(list, list->head->prev);
}
