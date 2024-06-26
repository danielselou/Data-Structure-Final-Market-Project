/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package lab2;

import java.lang.Comparable;

/**
 * Binary Search Tree implementation for Dictionary ADT
 */
class BST<Key extends Comparable<? super Key>, E> implements Dictionary<Key, E> {

    private BSTNode<Key, E> root;   // Root of the BST
    int nodecount;                  // Number of nodes in the BST

    /**
     * Constructor
     */
    BST() {
        root = null;
        nodecount = 0;
    }

    /**
     * Reinitialize tree
     */
    public void clear() {
        root = null;
        nodecount = 0;
    }

    /**
     * Insert a record into the tree.
     *
     * @param k Key value of the record.
     * @param e The record to insert.
     */
    public void insert(Key k, E e) {
        root = inserthelp(root, k, e);
        nodecount++;
    }

    /**
     * Remove a record from the tree.
     *
     * @param k Key value of record to remove.
     * @return The record removed, null if there is none.
     */
    public E remove(Key k) {
        E temp = findhelp(root, k);   // First find it
        if (temp != null) {
            root = removehelp(root, k); // Now remove it
            nodecount--;
        }
        return temp;
    }

    /**
     * Remove and return the root node from the dictionary.
     *
     * @return The record removed, null if tree is empty.
     */
    public E removeAny() {
        if (root == null) {
            return null;
        }
        E temp = root.element();
        root = removehelp(root, root.key());
        nodecount--;
        return temp;
    }

    /**
     * @return Record with key value k, null if none exist.
     * @param k The key value to find.
     */
    public E find(Key k) {
        return findhelp(root, k);
    }

    /**
     * @return The number of records in the dictionary.
     */
    public int size() {
        return nodecount;
    }
    
    /**
     * @return A pointer to the root node of the tree.
     */
    public BSTNode<Key, E> root() {
        return root;
    }

    private E findhelp(BSTNode<Key, E> rt, Key k) {
        if (rt == null) {
            return null;
        }
        if (rt.key().compareTo(k) > 0) {
            return findhelp(rt.left(), k);
        } else if (rt.key().compareTo(k) == 0) {
            return rt.element();
        } else {
            return findhelp(rt.right(), k);
        }
    }

    /**
     * @return The current subtree, modified to contain the new item
     */
    private BSTNode<Key, E> inserthelp(BSTNode<Key, E> rt, Key k, E e) {
        if (rt == null) {
            return new BSTNode<Key, E>(k, e);
        }
        if (rt.key().compareTo(k) > 0) {
            rt.setLeft(inserthelp(rt.left(), k, e));
        } else {
            rt.setRight(inserthelp(rt.right(), k, e));
        }
        return rt;
    }

    /**
     * Remove a node with key value k
     *
     * @return The tree with the node removed
     */
    private BSTNode<Key, E> removehelp(BSTNode<Key, E> rt, Key k) {
        if (rt == null) {
            return null;
        }
        if (rt.key().compareTo(k) > 0) {
            rt.setLeft(removehelp(rt.left(), k));
        } else if (rt.key().compareTo(k) < 0) {
            rt.setRight(removehelp(rt.right(), k));
        } else { // Found it
            if (rt.left() == null) {
                return rt.right();
            } else if (rt.right() == null) {
                return rt.left();
            } else { // Two children
                BSTNode<Key, E> temp = getmin(rt.right());
                rt.setElement(temp.element());
                rt.setKey(temp.key());
                rt.setRight(deletemin(rt.right()));
            }
        }
        return rt;
    }

    private BSTNode<Key, E> getmin(BSTNode<Key, E> rt) {
        if (rt.left() == null) {
            return rt;
        }
        return getmin(rt.left());
    }

    private BSTNode<Key, E> deletemin(BSTNode<Key, E> rt) {
        if (rt.left() == null) {
            return rt.right();
        }
        rt.setLeft(deletemin(rt.left()));
        return rt;
    }

    public String toString() {
        StringBuilder sb = new StringBuilder();
        traverseNodes(sb, "", "", root, false);
        return sb.toString();
    }
    public void traverseNodes(StringBuilder sb, String padding, String pointer, BSTNode<Key , E> node, boolean hasRightSibling) {
        if (node != null) {
            sb.append("\n");
            sb.append(padding);
            sb.append(pointer);
            sb.append(node.element());

            StringBuilder paddingBuilder = new StringBuilder(padding);
            if (hasRightSibling) {
                paddingBuilder.append("│  ");
            } else {
                paddingBuilder.append("   ");
            }

            String paddingForBoth = paddingBuilder.toString();
            String pointerRight = "└──";
            String pointerLeft = (node.right() != null) ? "├──" : "└──";

            traverseNodes(sb, paddingForBoth, pointerLeft, node.left(), node.right() != null);
            traverseNodes(sb, paddingForBoth, pointerRight, node.right(), false);
            
    }
}


}
