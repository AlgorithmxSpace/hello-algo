---
comments: true
---

# 7.5 &nbsp; AVL 树 *

在“二叉搜索树”章节中我们提到，在多次插入和删除操作后，二叉搜索树可能退化为链表。在这种情况下，所有操作的时间复杂度将从 $O(\log n)$ 劣化为 $O(n)$ 。

如图 7-24 所示，经过两次删除节点操作，这棵二叉搜索树便会退化为链表。

![AVL 树在删除节点后发生退化](avl_tree.assets/avltree_degradation_from_removing_node.png){ class="animation-figure" }

<p align="center"> 图 7-24 &nbsp; AVL 树在删除节点后发生退化 </p>

再例如，在图 7-25 所示的完美二叉树中插入两个节点后，树将严重向左倾斜，查找操作的时间复杂度也随之劣化。

![AVL 树在插入节点后发生退化](avl_tree.assets/avltree_degradation_from_inserting_node.png){ class="animation-figure" }

<p align="center"> 图 7-25 &nbsp; AVL 树在插入节点后发生退化 </p>

1962 年 G. M. Adelson-Velsky 和 E. M. Landis 在论文“An algorithm for the organization of information”中提出了 <u>AVL 树</u>。论文中详细描述了一系列操作，确保在持续添加和删除节点后，AVL 树不会退化，从而使得各种操作的时间复杂度保持在 $O(\log n)$ 级别。换句话说，在需要频繁进行增删查改操作的场景中，AVL 树能始终保持高效的数据操作性能，具有很好的应用价值。

## 7.5.1 &nbsp; AVL 树常见术语

AVL 树既是二叉搜索树，也是平衡二叉树，同时满足这两类二叉树的所有性质，因此是一种<u>平衡二叉搜索树（balanced binary search tree）</u>。

### 1. &nbsp; 节点高度

由于 AVL 树的相关操作需要获取节点高度，因此我们需要为节点类添加 `height` 变量：

=== "Python"

    ```python title=""
    class TreeNode:
        """AVL 树节点类"""
        def __init__(self, val: int):
            self.val: int = val                 # 节点值
            self.height: int = 0                # 节点高度
            self.left: TreeNode | None = None   # 左子节点引用
            self.right: TreeNode | None = None  # 右子节点引用
    ```

=== "C++"

    ```cpp title=""
    /* AVL 树节点类 */
    struct TreeNode {
        int val{};          // 节点值
        int height = 0;     // 节点高度
        TreeNode *left{};   // 左子节点
        TreeNode *right{};  // 右子节点
        TreeNode() = default;
        explicit TreeNode(int x) : val(x){}
    };
    ```

=== "Java"

    ```java title=""
    /* AVL 树节点类 */
    class TreeNode {
        public int val;        // 节点值
        public int height;     // 节点高度
        public TreeNode left;  // 左子节点
        public TreeNode right; // 右子节点
        public TreeNode(int x) { val = x; }
    }
    ```

=== "C#"

    ```csharp title=""
    /* AVL 树节点类 */
    class TreeNode(int? x) {
        public int? val = x;    // 节点值
        public int height;      // 节点高度
        public TreeNode? left;  // 左子节点引用
        public TreeNode? right; // 右子节点引用
    }
    ```

=== "Go"

    ```go title=""
    /* AVL 树节点结构体 */
    type TreeNode struct {
        Val    int       // 节点值
        Height int       // 节点高度
        Left   *TreeNode // 左子节点引用
        Right  *TreeNode // 右子节点引用
    }
    ```

=== "Swift"

    ```swift title=""
    /* AVL 树节点类 */
    class TreeNode {
        var val: Int // 节点值
        var height: Int // 节点高度
        var left: TreeNode? // 左子节点
        var right: TreeNode? // 右子节点

        init(x: Int) {
            val = x
            height = 0
        }
    }
    ```

=== "JS"

    ```javascript title=""
    /* AVL 树节点类 */
    class TreeNode {
        val; // 节点值
        height; //节点高度
        left; // 左子节点指针
        right; // 右子节点指针
        constructor(val, left, right, height) {
            this.val = val === undefined ? 0 : val;
            this.height = height === undefined ? 0 : height;
            this.left = left === undefined ? null : left;
            this.right = right === undefined ? null : right;
        }
    }
    ```

=== "TS"

    ```typescript title=""
    /* AVL 树节点类 */
    class TreeNode {
        val: number;            // 节点值
        height: number;         // 节点高度
        left: TreeNode | null;  // 左子节点指针
        right: TreeNode | null; // 右子节点指针
        constructor(val?: number, height?: number, left?: TreeNode | null, right?: TreeNode | null) {
            this.val = val === undefined ? 0 : val;
            this.height = height === undefined ? 0 : height;
            this.left = left === undefined ? null : left;
            this.right = right === undefined ? null : right;
        }
    }
    ```

=== "Dart"

    ```dart title=""
    /* AVL 树节点类 */
    class TreeNode {
      int val;         // 节点值
      int height;      // 节点高度
      TreeNode? left;  // 左子节点
      TreeNode? right; // 右子节点
      TreeNode(this.val, [this.height = 0, this.left, this.right]);
    }
    ```

=== "Rust"

    ```rust title=""
    use std::rc::Rc;
    use std::cell::RefCell;

    /* AVL 树节点结构体 */
    struct TreeNode {
        val: i32,                               // 节点值
        height: i32,                            // 节点高度
        left: Option<Rc<RefCell<TreeNode>>>,    // 左子节点
        right: Option<Rc<RefCell<TreeNode>>>,   // 右子节点
    }

    impl TreeNode {
        /* 构造方法 */
        fn new(val: i32) -> Rc<RefCell<Self>> {
            Rc::new(RefCell::new(Self {
                val,
                height: 0,
                left: None,
                right: None
            }))
        }
    }
    ```

=== "C"

    ```c title=""
    /* AVL 树节点结构体 */
    typedef struct TreeNode {
        int val;
        int height;
        struct TreeNode *left;
        struct TreeNode *right;
    } TreeNode;

    /* 构造函数 */
    TreeNode *newTreeNode(int val) {
        TreeNode *node;

        node = (TreeNode *)malloc(sizeof(TreeNode));
        node->val = val;
        node->height = 0;
        node->left = NULL;
        node->right = NULL;
        return node;
    }
    ```

=== "Kotlin"

    ```kotlin title=""
    /* AVL 树节点类 */
    class TreeNode(val _val: Int) {  // 节点值
        val height: Int = 0          // 节点高度
        val left: TreeNode? = null   // 左子节点
        val right: TreeNode? = null  // 右子节点
    }
    ```

=== "Ruby"

    ```ruby title=""
    ### AVL 树节点类 ###
    class TreeNode
      attr_accessor :val    # 节点值
      attr_accessor :height # 节点高度
      attr_accessor :left   # 左子节点引用
      attr_accessor :right  # 右子节点引用

      def initialize(val)
        @val = val
        @height = 0
      end
    end
    ```

=== "Zig"

    ```zig title=""

    ```

“节点高度”是指从该节点到它的最远叶节点的距离，即所经过的“边”的数量。需要特别注意的是，叶节点的高度为 $0$ ，而空节点的高度为 $-1$ 。我们将创建两个工具函数，分别用于获取和更新节点的高度：

=== "Python"

    ```python title="avl_tree.py"
    def height(self, node: TreeNode | None) -> int:
        """获取节点高度"""
        # 空节点高度为 -1 ，叶节点高度为 0
        if node is not None:
            return node.height
        return -1

    def update_height(self, node: TreeNode | None):
        """更新节点高度"""
        # 节点高度等于最高子树高度 + 1
        node.height = max([self.height(node.left), self.height(node.right)]) + 1
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 获取节点高度 */
    int height(TreeNode *node) {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node == nullptr ? -1 : node->height;
    }

    /* 更新节点高度 */
    void updateHeight(TreeNode *node) {
        // 节点高度等于最高子树高度 + 1
        node->height = max(height(node->left), height(node->right)) + 1;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 获取节点高度 */
    int height(TreeNode node) {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node == null ? -1 : node.height;
    }

    /* 更新节点高度 */
    void updateHeight(TreeNode node) {
        // 节点高度等于最高子树高度 + 1
        node.height = Math.max(height(node.left), height(node.right)) + 1;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 获取节点高度 */
    int Height(TreeNode? node) {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node == null ? -1 : node.height;
    }

    /* 更新节点高度 */
    void UpdateHeight(TreeNode node) {
        // 节点高度等于最高子树高度 + 1
        node.height = Math.Max(Height(node.left), Height(node.right)) + 1;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 获取节点高度 */
    func (t *aVLTree) height(node *TreeNode) int {
        // 空节点高度为 -1 ，叶节点高度为 0
        if node != nil {
            return node.Height
        }
        return -1
    }

    /* 更新节点高度 */
    func (t *aVLTree) updateHeight(node *TreeNode) {
        lh := t.height(node.Left)
        rh := t.height(node.Right)
        // 节点高度等于最高子树高度 + 1
        if lh > rh {
            node.Height = lh + 1
        } else {
            node.Height = rh + 1
        }
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 获取节点高度 */
    func height(node: TreeNode?) -> Int {
        // 空节点高度为 -1 ，叶节点高度为 0
        node?.height ?? -1
    }

    /* 更新节点高度 */
    func updateHeight(node: TreeNode?) {
        // 节点高度等于最高子树高度 + 1
        node?.height = max(height(node: node?.left), height(node: node?.right)) + 1
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 获取节点高度 */
    height(node) {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node === null ? -1 : node.height;
    }

    /* 更新节点高度 */
    #updateHeight(node) {
        // 节点高度等于最高子树高度 + 1
        node.height =
            Math.max(this.height(node.left), this.height(node.right)) + 1;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 获取节点高度 */
    height(node: TreeNode): number {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node === null ? -1 : node.height;
    }

    /* 更新节点高度 */
    updateHeight(node: TreeNode): void {
        // 节点高度等于最高子树高度 + 1
        node.height =
            Math.max(this.height(node.left), this.height(node.right)) + 1;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 获取节点高度 */
    int height(TreeNode? node) {
      // 空节点高度为 -1 ，叶节点高度为 0
      return node == null ? -1 : node.height;
    }

    /* 更新节点高度 */
    void updateHeight(TreeNode? node) {
      // 节点高度等于最高子树高度 + 1
      node!.height = max(height(node.left), height(node.right)) + 1;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 获取节点高度 */
    fn height(node: OptionTreeNodeRc) -> i32 {
        // 空节点高度为 -1 ，叶节点高度为 0
        match node {
            Some(node) => node.borrow().height,
            None => -1,
        }
    }

    /* 更新节点高度 */
    fn update_height(node: OptionTreeNodeRc) {
        if let Some(node) = node {
            let left = node.borrow().left.clone();
            let right = node.borrow().right.clone();
            // 节点高度等于最高子树高度 + 1
            node.borrow_mut().height = std::cmp::max(Self::height(left), Self::height(right)) + 1;
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 获取节点高度 */
    int height(TreeNode *node) {
        // 空节点高度为 -1 ，叶节点高度为 0
        if (node != NULL) {
            return node->height;
        }
        return -1;
    }

    /* 更新节点高度 */
    void updateHeight(TreeNode *node) {
        int lh = height(node->left);
        int rh = height(node->right);
        // 节点高度等于最高子树高度 + 1
        if (lh > rh) {
            node->height = lh + 1;
        } else {
            node->height = rh + 1;
        }
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 获取节点高度 */
    fun height(node: TreeNode?): Int {
        // 空节点高度为 -1 ，叶节点高度为 0
        return node?.height ?: -1
    }

    /* 更新节点高度 */
    fun updateHeight(node: TreeNode?) {
        // 节点高度等于最高子树高度 + 1
        node?.height = max(height(node?.left), height(node?.right)) + 1
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 获取节点高度 ###
    def height(node)
      # 空节点高度为 -1 ，叶节点高度为 0
      return node.height unless node.nil?

      -1
    end

    ### 更新节点高度 ###
    def update_height(node)
      # 节点高度等于最高子树高度 + 1
      node.height = [height(node.left), height(node.right)].max + 1
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 获取节点高度
    fn height(self: *Self, node: ?*inc.TreeNode(T)) i32 {
        _ = self;
        // 空节点高度为 -1 ，叶节点高度为 0
        return if (node == null) -1 else node.?.height;
    }

    // 更新节点高度
    fn updateHeight(self: *Self, node: ?*inc.TreeNode(T)) void {
        // 节点高度等于最高子树高度 + 1
        node.?.height = @max(self.height(node.?.left), self.height(node.?.right)) + 1;
    }
    ```

### 2. &nbsp; 节点平衡因子

节点的<u>平衡因子（balance factor）</u>定义为节点左子树的高度减去右子树的高度，同时规定空节点的平衡因子为 $0$ 。我们同样将获取节点平衡因子的功能封装成函数，方便后续使用：

=== "Python"

    ```python title="avl_tree.py"
    def balance_factor(self, node: TreeNode | None) -> int:
        """获取平衡因子"""
        # 空节点平衡因子为 0
        if node is None:
            return 0
        # 节点平衡因子 = 左子树高度 - 右子树高度
        return self.height(node.left) - self.height(node.right)
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 获取平衡因子 */
    int balanceFactor(TreeNode *node) {
        // 空节点平衡因子为 0
        if (node == nullptr)
            return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return height(node->left) - height(node->right);
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 获取平衡因子 */
    int balanceFactor(TreeNode node) {
        // 空节点平衡因子为 0
        if (node == null)
            return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return height(node.left) - height(node.right);
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 获取平衡因子 */
    int BalanceFactor(TreeNode? node) {
        // 空节点平衡因子为 0
        if (node == null) return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return Height(node.left) - Height(node.right);
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 获取平衡因子 */
    func (t *aVLTree) balanceFactor(node *TreeNode) int {
        // 空节点平衡因子为 0
        if node == nil {
            return 0
        }
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return t.height(node.Left) - t.height(node.Right)
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 获取平衡因子 */
    func balanceFactor(node: TreeNode?) -> Int {
        // 空节点平衡因子为 0
        guard let node = node else { return 0 }
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return height(node: node.left) - height(node: node.right)
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 获取平衡因子 */
    balanceFactor(node) {
        // 空节点平衡因子为 0
        if (node === null) return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return this.height(node.left) - this.height(node.right);
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 获取平衡因子 */
    balanceFactor(node: TreeNode): number {
        // 空节点平衡因子为 0
        if (node === null) return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return this.height(node.left) - this.height(node.right);
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 获取平衡因子 */
    int balanceFactor(TreeNode? node) {
      // 空节点平衡因子为 0
      if (node == null) return 0;
      // 节点平衡因子 = 左子树高度 - 右子树高度
      return height(node.left) - height(node.right);
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 获取平衡因子 */
    fn balance_factor(node: OptionTreeNodeRc) -> i32 {
        match node {
            // 空节点平衡因子为 0
            None => 0,
            // 节点平衡因子 = 左子树高度 - 右子树高度
            Some(node) => {
                Self::height(node.borrow().left.clone()) - Self::height(node.borrow().right.clone())
            }
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 获取平衡因子 */
    int balanceFactor(TreeNode *node) {
        // 空节点平衡因子为 0
        if (node == NULL) {
            return 0;
        }
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return height(node->left) - height(node->right);
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 获取平衡因子 */
    fun balanceFactor(node: TreeNode?): Int {
        // 空节点平衡因子为 0
        if (node == null) return 0
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return height(node.left) - height(node.right)
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 获取平衡因子 ###
    def balance_factor(node)
      # 空节点平衡因子为 0
      return 0 if node.nil?

      # 节点平衡因子 = 左子树高度 - 右子树高度
      height(node.left) - height(node.right)
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 获取平衡因子
    fn balanceFactor(self: *Self, node: ?*inc.TreeNode(T)) i32 {
        // 空节点平衡因子为 0
        if (node == null) return 0;
        // 节点平衡因子 = 左子树高度 - 右子树高度
        return self.height(node.?.left) - self.height(node.?.right);
    }
    ```

!!! tip

    设平衡因子为 $f$ ，则一棵 AVL 树的任意节点的平衡因子皆满足 $-1 \le f \le 1$ 。

## 7.5.2 &nbsp; AVL 树旋转

AVL 树的特点在于“旋转”操作，它能够在不影响二叉树的中序遍历序列的前提下，使失衡节点重新恢复平衡。换句话说，**旋转操作既能保持“二叉搜索树”的性质，也能使树重新变为“平衡二叉树”**。

我们将平衡因子绝对值 $> 1$ 的节点称为“失衡节点”。根据节点失衡情况的不同，旋转操作分为四种：右旋、左旋、先右旋后左旋、先左旋后右旋。下面详细介绍这些旋转操作。

### 1. &nbsp; 右旋

如图 7-26 所示，节点下方为平衡因子。从底至顶看，二叉树中首个失衡节点是“节点 3”。我们关注以该失衡节点为根节点的子树，将该节点记为 `node` ，其左子节点记为 `child` ，执行“右旋”操作。完成右旋后，子树恢复平衡，并且仍然保持二叉搜索树的性质。

=== "<1>"
    ![右旋操作步骤](avl_tree.assets/avltree_right_rotate_step1.png){ class="animation-figure" }

=== "<2>"
    ![avltree_right_rotate_step2](avl_tree.assets/avltree_right_rotate_step2.png){ class="animation-figure" }

=== "<3>"
    ![avltree_right_rotate_step3](avl_tree.assets/avltree_right_rotate_step3.png){ class="animation-figure" }

=== "<4>"
    ![avltree_right_rotate_step4](avl_tree.assets/avltree_right_rotate_step4.png){ class="animation-figure" }

<p align="center"> 图 7-26 &nbsp; 右旋操作步骤 </p>

如图 7-27 所示，当节点 `child` 有右子节点（记为 `grand_child` ）时，需要在右旋中添加一步：将 `grand_child` 作为 `node` 的左子节点。

![有 grand_child 的右旋操作](avl_tree.assets/avltree_right_rotate_with_grandchild.png){ class="animation-figure" }

<p align="center"> 图 7-27 &nbsp; 有 grand_child 的右旋操作 </p>

“向右旋转”是一种形象化的说法，实际上需要通过修改节点指针来实现，代码如下所示：

=== "Python"

    ```python title="avl_tree.py"
    def right_rotate(self, node: TreeNode | None) -> TreeNode | None:
        """右旋操作"""
        child = node.left
        grand_child = child.right
        # 以 child 为原点，将 node 向右旋转
        child.right = node
        node.left = grand_child
        # 更新节点高度
        self.update_height(node)
        self.update_height(child)
        # 返回旋转后子树的根节点
        return child
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 右旋操作 */
    TreeNode *rightRotate(TreeNode *node) {
        TreeNode *child = node->left;
        TreeNode *grandChild = child->right;
        // 以 child 为原点，将 node 向右旋转
        child->right = node;
        node->left = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 右旋操作 */
    TreeNode rightRotate(TreeNode node) {
        TreeNode child = node.left;
        TreeNode grandChild = child.right;
        // 以 child 为原点，将 node 向右旋转
        child.right = node;
        node.left = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 右旋操作 */
    TreeNode? RightRotate(TreeNode? node) {
        TreeNode? child = node?.left;
        TreeNode? grandChild = child?.right;
        // 以 child 为原点，将 node 向右旋转
        child.right = node;
        node.left = grandChild;
        // 更新节点高度
        UpdateHeight(node);
        UpdateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 右旋操作 */
    func (t *aVLTree) rightRotate(node *TreeNode) *TreeNode {
        child := node.Left
        grandChild := child.Right
        // 以 child 为原点，将 node 向右旋转
        child.Right = node
        node.Left = grandChild
        // 更新节点高度
        t.updateHeight(node)
        t.updateHeight(child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 右旋操作 */
    func rightRotate(node: TreeNode?) -> TreeNode? {
        let child = node?.left
        let grandChild = child?.right
        // 以 child 为原点，将 node 向右旋转
        child?.right = node
        node?.left = grandChild
        // 更新节点高度
        updateHeight(node: node)
        updateHeight(node: child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 右旋操作 */
    #rightRotate(node) {
        const child = node.left;
        const grandChild = child.right;
        // 以 child 为原点，将 node 向右旋转
        child.right = node;
        node.left = grandChild;
        // 更新节点高度
        this.#updateHeight(node);
        this.#updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 右旋操作 */
    rightRotate(node: TreeNode): TreeNode {
        const child = node.left;
        const grandChild = child.right;
        // 以 child 为原点，将 node 向右旋转
        child.right = node;
        node.left = grandChild;
        // 更新节点高度
        this.updateHeight(node);
        this.updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 右旋操作 */
    TreeNode? rightRotate(TreeNode? node) {
      TreeNode? child = node!.left;
      TreeNode? grandChild = child!.right;
      // 以 child 为原点，将 node 向右旋转
      child.right = node;
      node.left = grandChild;
      // 更新节点高度
      updateHeight(node);
      updateHeight(child);
      // 返回旋转后子树的根节点
      return child;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 右旋操作 */
    fn right_rotate(node: OptionTreeNodeRc) -> OptionTreeNodeRc {
        match node {
            Some(node) => {
                let child = node.borrow().left.clone().unwrap();
                let grand_child = child.borrow().right.clone();
                // 以 child 为原点，将 node 向右旋转
                child.borrow_mut().right = Some(node.clone());
                node.borrow_mut().left = grand_child;
                // 更新节点高度
                Self::update_height(Some(node));
                Self::update_height(Some(child.clone()));
                // 返回旋转后子树的根节点
                Some(child)
            }
            None => None,
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 右旋操作 */
    TreeNode *rightRotate(TreeNode *node) {
        TreeNode *child, *grandChild;
        child = node->left;
        grandChild = child->right;
        // 以 child 为原点，将 node 向右旋转
        child->right = node;
        node->left = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 右旋操作 */
    fun rightRotate(node: TreeNode?): TreeNode {
        val child = node!!.left
        val grandChild = child!!.right
        // 以 child 为原点，将 node 向右旋转
        child.right = node
        node.left = grandChild
        // 更新节点高度
        updateHeight(node)
        updateHeight(child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 右旋操作 ###
    def right_rotate(node)
      child = node.left
      grand_child = child.right
      # 以 child 为原点，将 node 向右旋转
      child.right = node
      node.left = grand_child
      # 更新节点高度
      update_height(node)
      update_height(child)
      # 返回旋转后子树的根节点
      child
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 右旋操作
    fn rightRotate(self: *Self, node: ?*inc.TreeNode(T)) ?*inc.TreeNode(T) {
        var child = node.?.left;
        var grandChild = child.?.right;
        // 以 child 为原点，将 node 向右旋转
        child.?.right = node;
        node.?.left = grandChild;
        // 更新节点高度
        self.updateHeight(node);
        self.updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

### 2. &nbsp; 左旋

相应地，如果考虑上述失衡二叉树的“镜像”，则需要执行图 7-28 所示的“左旋”操作。

![左旋操作](avl_tree.assets/avltree_left_rotate.png){ class="animation-figure" }

<p align="center"> 图 7-28 &nbsp; 左旋操作 </p>

同理，如图 7-29 所示，当节点 `child` 有左子节点（记为 `grand_child` ）时，需要在左旋中添加一步：将 `grand_child` 作为 `node` 的右子节点。

![有 grand_child 的左旋操作](avl_tree.assets/avltree_left_rotate_with_grandchild.png){ class="animation-figure" }

<p align="center"> 图 7-29 &nbsp; 有 grand_child 的左旋操作 </p>

可以观察到，**右旋和左旋操作在逻辑上是镜像对称的，它们分别解决的两种失衡情况也是对称的**。基于对称性，我们只需将右旋的实现代码中的所有的 `left` 替换为 `right` ，将所有的 `right` 替换为 `left` ，即可得到左旋的实现代码：

=== "Python"

    ```python title="avl_tree.py"
    def left_rotate(self, node: TreeNode | None) -> TreeNode | None:
        """左旋操作"""
        child = node.right
        grand_child = child.left
        # 以 child 为原点，将 node 向左旋转
        child.left = node
        node.right = grand_child
        # 更新节点高度
        self.update_height(node)
        self.update_height(child)
        # 返回旋转后子树的根节点
        return child
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 左旋操作 */
    TreeNode *leftRotate(TreeNode *node) {
        TreeNode *child = node->right;
        TreeNode *grandChild = child->left;
        // 以 child 为原点，将 node 向左旋转
        child->left = node;
        node->right = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 左旋操作 */
    TreeNode leftRotate(TreeNode node) {
        TreeNode child = node.right;
        TreeNode grandChild = child.left;
        // 以 child 为原点，将 node 向左旋转
        child.left = node;
        node.right = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 左旋操作 */
    TreeNode? LeftRotate(TreeNode? node) {
        TreeNode? child = node?.right;
        TreeNode? grandChild = child?.left;
        // 以 child 为原点，将 node 向左旋转
        child.left = node;
        node.right = grandChild;
        // 更新节点高度
        UpdateHeight(node);
        UpdateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 左旋操作 */
    func (t *aVLTree) leftRotate(node *TreeNode) *TreeNode {
        child := node.Right
        grandChild := child.Left
        // 以 child 为原点，将 node 向左旋转
        child.Left = node
        node.Right = grandChild
        // 更新节点高度
        t.updateHeight(node)
        t.updateHeight(child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 左旋操作 */
    func leftRotate(node: TreeNode?) -> TreeNode? {
        let child = node?.right
        let grandChild = child?.left
        // 以 child 为原点，将 node 向左旋转
        child?.left = node
        node?.right = grandChild
        // 更新节点高度
        updateHeight(node: node)
        updateHeight(node: child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 左旋操作 */
    #leftRotate(node) {
        const child = node.right;
        const grandChild = child.left;
        // 以 child 为原点，将 node 向左旋转
        child.left = node;
        node.right = grandChild;
        // 更新节点高度
        this.#updateHeight(node);
        this.#updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 左旋操作 */
    leftRotate(node: TreeNode): TreeNode {
        const child = node.right;
        const grandChild = child.left;
        // 以 child 为原点，将 node 向左旋转
        child.left = node;
        node.right = grandChild;
        // 更新节点高度
        this.updateHeight(node);
        this.updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 左旋操作 */
    TreeNode? leftRotate(TreeNode? node) {
      TreeNode? child = node!.right;
      TreeNode? grandChild = child!.left;
      // 以 child 为原点，将 node 向左旋转
      child.left = node;
      node.right = grandChild;
      // 更新节点高度
      updateHeight(node);
      updateHeight(child);
      // 返回旋转后子树的根节点
      return child;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 左旋操作 */
    fn left_rotate(node: OptionTreeNodeRc) -> OptionTreeNodeRc {
        match node {
            Some(node) => {
                let child = node.borrow().right.clone().unwrap();
                let grand_child = child.borrow().left.clone();
                // 以 child 为原点，将 node 向左旋转
                child.borrow_mut().left = Some(node.clone());
                node.borrow_mut().right = grand_child;
                // 更新节点高度
                Self::update_height(Some(node));
                Self::update_height(Some(child.clone()));
                // 返回旋转后子树的根节点
                Some(child)
            }
            None => None,
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 左旋操作 */
    TreeNode *leftRotate(TreeNode *node) {
        TreeNode *child, *grandChild;
        child = node->right;
        grandChild = child->left;
        // 以 child 为原点，将 node 向左旋转
        child->left = node;
        node->right = grandChild;
        // 更新节点高度
        updateHeight(node);
        updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 左旋操作 */
    fun leftRotate(node: TreeNode?): TreeNode {
        val child = node!!.right
        val grandChild = child!!.left
        // 以 child 为原点，将 node 向左旋转
        child.left = node
        node.right = grandChild
        // 更新节点高度
        updateHeight(node)
        updateHeight(child)
        // 返回旋转后子树的根节点
        return child
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 左旋操作 ###
    def left_rotate(node)
      child = node.right
      grand_child = child.left
      # 以 child 为原点，将 node 向左旋转
      child.left = node
      node.right = grand_child
      # 更新节点高度
      update_height(node)
      update_height(child)
      # 返回旋转后子树的根节点
      child
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 左旋操作
    fn leftRotate(self: *Self, node: ?*inc.TreeNode(T)) ?*inc.TreeNode(T) {
        var child = node.?.right;
        var grandChild = child.?.left;
        // 以 child 为原点，将 node 向左旋转
        child.?.left = node;
        node.?.right = grandChild;
        // 更新节点高度
        self.updateHeight(node);
        self.updateHeight(child);
        // 返回旋转后子树的根节点
        return child;
    }
    ```

### 3. &nbsp; 先左旋后右旋

对于图 7-30 中的失衡节点 3 ，仅使用左旋或右旋都无法使子树恢复平衡。此时需要先对 `child` 执行“左旋”，再对 `node` 执行“右旋”。

![先左旋后右旋](avl_tree.assets/avltree_left_right_rotate.png){ class="animation-figure" }

<p align="center"> 图 7-30 &nbsp; 先左旋后右旋 </p>

### 4. &nbsp; 先右旋后左旋

如图 7-31 所示，对于上述失衡二叉树的镜像情况，需要先对 `child` 执行“右旋”，再对 `node` 执行“左旋”。

![先右旋后左旋](avl_tree.assets/avltree_right_left_rotate.png){ class="animation-figure" }

<p align="center"> 图 7-31 &nbsp; 先右旋后左旋 </p>

### 5. &nbsp; 旋转的选择

图 7-32 展示的四种失衡情况与上述案例逐个对应，分别需要采用右旋、先左旋后右旋、先右旋后左旋、左旋的操作。

![AVL 树的四种旋转情况](avl_tree.assets/avltree_rotation_cases.png){ class="animation-figure" }

<p align="center"> 图 7-32 &nbsp; AVL 树的四种旋转情况 </p>

如下表所示，我们通过判断失衡节点的平衡因子以及较高一侧子节点的平衡因子的正负号，来确定失衡节点属于图 7-32 中的哪种情况。

<p align="center"> 表 7-3 &nbsp; 四种旋转情况的选择条件 </p>

<div class="center-table" markdown>

| 失衡节点的平衡因子 | 子节点的平衡因子 | 应采用的旋转方法 |
| ------------------ | ---------------- | ---------------- |
| $> 1$ （左偏树）   | $\geq 0$         | 右旋             |
| $> 1$ （左偏树）   | $<0$             | 先左旋后右旋     |
| $< -1$ （右偏树）  | $\leq 0$         | 左旋             |
| $< -1$ （右偏树）  | $>0$             | 先右旋后左旋     |

</div>

为了便于使用，我们将旋转操作封装成一个函数。**有了这个函数，我们就能对各种失衡情况进行旋转，使失衡节点重新恢复平衡**。代码如下所示：

=== "Python"

    ```python title="avl_tree.py"
    def rotate(self, node: TreeNode | None) -> TreeNode | None:
        """执行旋转操作，使该子树重新恢复平衡"""
        # 获取节点 node 的平衡因子
        balance_factor = self.balance_factor(node)
        # 左偏树
        if balance_factor > 1:
            if self.balance_factor(node.left) >= 0:
                # 右旋
                return self.right_rotate(node)
            else:
                # 先左旋后右旋
                node.left = self.left_rotate(node.left)
                return self.right_rotate(node)
        # 右偏树
        elif balance_factor < -1:
            if self.balance_factor(node.right) <= 0:
                # 左旋
                return self.left_rotate(node)
            else:
                # 先右旋后左旋
                node.right = self.right_rotate(node.right)
                return self.left_rotate(node)
        # 平衡树，无须旋转，直接返回
        return node
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    TreeNode *rotate(TreeNode *node) {
        // 获取节点 node 的平衡因子
        int _balanceFactor = balanceFactor(node);
        // 左偏树
        if (_balanceFactor > 1) {
            if (balanceFactor(node->left) >= 0) {
                // 右旋
                return rightRotate(node);
            } else {
                // 先左旋后右旋
                node->left = leftRotate(node->left);
                return rightRotate(node);
            }
        }
        // 右偏树
        if (_balanceFactor < -1) {
            if (balanceFactor(node->right) <= 0) {
                // 左旋
                return leftRotate(node);
            } else {
                // 先右旋后左旋
                node->right = rightRotate(node->right);
                return leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    TreeNode rotate(TreeNode node) {
        // 获取节点 node 的平衡因子
        int balanceFactor = balanceFactor(node);
        // 左偏树
        if (balanceFactor > 1) {
            if (balanceFactor(node.left) >= 0) {
                // 右旋
                return rightRotate(node);
            } else {
                // 先左旋后右旋
                node.left = leftRotate(node.left);
                return rightRotate(node);
            }
        }
        // 右偏树
        if (balanceFactor < -1) {
            if (balanceFactor(node.right) <= 0) {
                // 左旋
                return leftRotate(node);
            } else {
                // 先右旋后左旋
                node.right = rightRotate(node.right);
                return leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    TreeNode? Rotate(TreeNode? node) {
        // 获取节点 node 的平衡因子
        int balanceFactorInt = BalanceFactor(node);
        // 左偏树
        if (balanceFactorInt > 1) {
            if (BalanceFactor(node?.left) >= 0) {
                // 右旋
                return RightRotate(node);
            } else {
                // 先左旋后右旋
                node!.left = LeftRotate(node!.left);
                return RightRotate(node);
            }
        }
        // 右偏树
        if (balanceFactorInt < -1) {
            if (BalanceFactor(node?.right) <= 0) {
                // 左旋
                return LeftRotate(node);
            } else {
                // 先右旋后左旋
                node!.right = RightRotate(node!.right);
                return LeftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    func (t *aVLTree) rotate(node *TreeNode) *TreeNode {
        // 获取节点 node 的平衡因子
        // Go 推荐短变量，这里 bf 指代 t.balanceFactor
        bf := t.balanceFactor(node)
        // 左偏树
        if bf > 1 {
            if t.balanceFactor(node.Left) >= 0 {
                // 右旋
                return t.rightRotate(node)
            } else {
                // 先左旋后右旋
                node.Left = t.leftRotate(node.Left)
                return t.rightRotate(node)
            }
        }
        // 右偏树
        if bf < -1 {
            if t.balanceFactor(node.Right) <= 0 {
                // 左旋
                return t.leftRotate(node)
            } else {
                // 先右旋后左旋
                node.Right = t.rightRotate(node.Right)
                return t.leftRotate(node)
            }
        }
        // 平衡树，无须旋转，直接返回
        return node
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    func rotate(node: TreeNode?) -> TreeNode? {
        // 获取节点 node 的平衡因子
        let balanceFactor = balanceFactor(node: node)
        // 左偏树
        if balanceFactor > 1 {
            if self.balanceFactor(node: node?.left) >= 0 {
                // 右旋
                return rightRotate(node: node)
            } else {
                // 先左旋后右旋
                node?.left = leftRotate(node: node?.left)
                return rightRotate(node: node)
            }
        }
        // 右偏树
        if balanceFactor < -1 {
            if self.balanceFactor(node: node?.right) <= 0 {
                // 左旋
                return leftRotate(node: node)
            } else {
                // 先右旋后左旋
                node?.right = rightRotate(node: node?.right)
                return leftRotate(node: node)
            }
        }
        // 平衡树，无须旋转，直接返回
        return node
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    #rotate(node) {
        // 获取节点 node 的平衡因子
        const balanceFactor = this.balanceFactor(node);
        // 左偏树
        if (balanceFactor > 1) {
            if (this.balanceFactor(node.left) >= 0) {
                // 右旋
                return this.#rightRotate(node);
            } else {
                // 先左旋后右旋
                node.left = this.#leftRotate(node.left);
                return this.#rightRotate(node);
            }
        }
        // 右偏树
        if (balanceFactor < -1) {
            if (this.balanceFactor(node.right) <= 0) {
                // 左旋
                return this.#leftRotate(node);
            } else {
                // 先右旋后左旋
                node.right = this.#rightRotate(node.right);
                return this.#leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    rotate(node: TreeNode): TreeNode {
        // 获取节点 node 的平衡因子
        const balanceFactor = this.balanceFactor(node);
        // 左偏树
        if (balanceFactor > 1) {
            if (this.balanceFactor(node.left) >= 0) {
                // 右旋
                return this.rightRotate(node);
            } else {
                // 先左旋后右旋
                node.left = this.leftRotate(node.left);
                return this.rightRotate(node);
            }
        }
        // 右偏树
        if (balanceFactor < -1) {
            if (this.balanceFactor(node.right) <= 0) {
                // 左旋
                return this.leftRotate(node);
            } else {
                // 先右旋后左旋
                node.right = this.rightRotate(node.right);
                return this.leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    TreeNode? rotate(TreeNode? node) {
      // 获取节点 node 的平衡因子
      int factor = balanceFactor(node);
      // 左偏树
      if (factor > 1) {
        if (balanceFactor(node!.left) >= 0) {
          // 右旋
          return rightRotate(node);
        } else {
          // 先左旋后右旋
          node.left = leftRotate(node.left);
          return rightRotate(node);
        }
      }
      // 右偏树
      if (factor < -1) {
        if (balanceFactor(node!.right) <= 0) {
          // 左旋
          return leftRotate(node);
        } else {
          // 先右旋后左旋
          node.right = rightRotate(node.right);
          return leftRotate(node);
        }
      }
      // 平衡树，无须旋转，直接返回
      return node;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    fn rotate(node: OptionTreeNodeRc) -> OptionTreeNodeRc {
        // 获取节点 node 的平衡因子
        let balance_factor = Self::balance_factor(node.clone());
        // 左偏树
        if balance_factor > 1 {
            let node = node.unwrap();
            if Self::balance_factor(node.borrow().left.clone()) >= 0 {
                // 右旋
                Self::right_rotate(Some(node))
            } else {
                // 先左旋后右旋
                let left = node.borrow().left.clone();
                node.borrow_mut().left = Self::left_rotate(left);
                Self::right_rotate(Some(node))
            }
        }
        // 右偏树
        else if balance_factor < -1 {
            let node = node.unwrap();
            if Self::balance_factor(node.borrow().right.clone()) <= 0 {
                // 左旋
                Self::left_rotate(Some(node))
            } else {
                // 先右旋后左旋
                let right = node.borrow().right.clone();
                node.borrow_mut().right = Self::right_rotate(right);
                Self::left_rotate(Some(node))
            }
        } else {
            // 平衡树，无须旋转，直接返回
            node
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    TreeNode *rotate(TreeNode *node) {
        // 获取节点 node 的平衡因子
        int bf = balanceFactor(node);
        // 左偏树
        if (bf > 1) {
            if (balanceFactor(node->left) >= 0) {
                // 右旋
                return rightRotate(node);
            } else {
                // 先左旋后右旋
                node->left = leftRotate(node->left);
                return rightRotate(node);
            }
        }
        // 右偏树
        if (bf < -1) {
            if (balanceFactor(node->right) <= 0) {
                // 左旋
                return leftRotate(node);
            } else {
                // 先右旋后左旋
                node->right = rightRotate(node->right);
                return leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 执行旋转操作，使该子树重新恢复平衡 */
    fun rotate(node: TreeNode): TreeNode {
        // 获取节点 node 的平衡因子
        val balanceFactor = balanceFactor(node)
        // 左偏树
        if (balanceFactor > 1) {
            if (balanceFactor(node.left) >= 0) {
                // 右旋
                return rightRotate(node)
            } else {
                // 先左旋后右旋
                node.left = leftRotate(node.left)
                return rightRotate(node)
            }
        }
        // 右偏树
        if (balanceFactor < -1) {
            if (balanceFactor(node.right) <= 0) {
                // 左旋
                return leftRotate(node)
            } else {
                // 先右旋后左旋
                node.right = rightRotate(node.right)
                return leftRotate(node)
            }
        }
        // 平衡树，无须旋转，直接返回
        return node
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 执行旋转操作，使该子树重新恢复平衡 ###
    def rotate(node)
      # 获取节点 node 的平衡因子
      balance_factor = balance_factor(node)
      # 左遍树
      if balance_factor > 1
        if balance_factor(node.left) >= 0
          # 右旋
          return right_rotate(node)
        else
          # 先左旋后右旋
          node.left = left_rotate(node.left)
          return right_rotate(node)
        end
      # 右遍树
      elsif balance_factor < -1
        if balance_factor(node.right) <= 0
          # 左旋
          return left_rotate(node)
        else
          # 先右旋后左旋
          node.right = right_rotate(node.right)
          return left_rotate(node)
        end
      end
      # 平衡树，无须旋转，直接返回
      node
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 执行旋转操作，使该子树重新恢复平衡
    fn rotate(self: *Self, node: ?*inc.TreeNode(T)) ?*inc.TreeNode(T) {
        // 获取节点 node 的平衡因子
        var balance_factor = self.balanceFactor(node);
        // 左偏树
        if (balance_factor > 1) {
            if (self.balanceFactor(node.?.left) >= 0) {
                // 右旋
                return self.rightRotate(node);
            } else {
                // 先左旋后右旋
                node.?.left = self.leftRotate(node.?.left);
                return self.rightRotate(node);
            }
        }
        // 右偏树
        if (balance_factor < -1) {
            if (self.balanceFactor(node.?.right) <= 0) {
                // 左旋
                return self.leftRotate(node);
            } else {
                // 先右旋后左旋
                node.?.right = self.rightRotate(node.?.right);
                return self.leftRotate(node);
            }
        }
        // 平衡树，无须旋转，直接返回
        return node;
    }
    ```

## 7.5.3 &nbsp; AVL 树常用操作

### 1. &nbsp; 插入节点

AVL 树的节点插入操作与二叉搜索树在主体上类似。唯一的区别在于，在 AVL 树中插入节点后，从该节点到根节点的路径上可能会出现一系列失衡节点。因此，**我们需要从这个节点开始，自底向上执行旋转操作，使所有失衡节点恢复平衡**。代码如下所示：

=== "Python"

    ```python title="avl_tree.py"
    def insert(self, val):
        """插入节点"""
        self._root = self.insert_helper(self._root, val)

    def insert_helper(self, node: TreeNode | None, val: int) -> TreeNode:
        """递归插入节点（辅助方法）"""
        if node is None:
            return TreeNode(val)
        # 1. 查找插入位置并插入节点
        if val < node.val:
            node.left = self.insert_helper(node.left, val)
        elif val > node.val:
            node.right = self.insert_helper(node.right, val)
        else:
            # 重复节点不插入，直接返回
            return node
        # 更新节点高度
        self.update_height(node)
        # 2. 执行旋转操作，使该子树重新恢复平衡
        return self.rotate(node)
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 插入节点 */
    void insert(int val) {
        root = insertHelper(root, val);
    }

    /* 递归插入节点（辅助方法） */
    TreeNode *insertHelper(TreeNode *node, int val) {
        if (node == nullptr)
            return new TreeNode(val);
        /* 1. 查找插入位置并插入节点 */
        if (val < node->val)
            node->left = insertHelper(node->left, val);
        else if (val > node->val)
            node->right = insertHelper(node->right, val);
        else
            return node;    // 重复节点不插入，直接返回
        updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 插入节点 */
    void insert(int val) {
        root = insertHelper(root, val);
    }

    /* 递归插入节点（辅助方法） */
    TreeNode insertHelper(TreeNode node, int val) {
        if (node == null)
            return new TreeNode(val);
        /* 1. 查找插入位置并插入节点 */
        if (val < node.val)
            node.left = insertHelper(node.left, val);
        else if (val > node.val)
            node.right = insertHelper(node.right, val);
        else
            return node; // 重复节点不插入，直接返回
        updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 插入节点 */
    void Insert(int val) {
        root = InsertHelper(root, val);
    }

    /* 递归插入节点（辅助方法） */
    TreeNode? InsertHelper(TreeNode? node, int val) {
        if (node == null) return new TreeNode(val);
        /* 1. 查找插入位置并插入节点 */
        if (val < node.val)
            node.left = InsertHelper(node.left, val);
        else if (val > node.val)
            node.right = InsertHelper(node.right, val);
        else
            return node;     // 重复节点不插入，直接返回
        UpdateHeight(node);  // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = Rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 插入节点 */
    func (t *aVLTree) insert(val int) {
        t.root = t.insertHelper(t.root, val)
    }

    /* 递归插入节点（辅助函数） */
    func (t *aVLTree) insertHelper(node *TreeNode, val int) *TreeNode {
        if node == nil {
            return NewTreeNode(val)
        }
        /* 1. 查找插入位置并插入节点 */
        if val < node.Val.(int) {
            node.Left = t.insertHelper(node.Left, val)
        } else if val > node.Val.(int) {
            node.Right = t.insertHelper(node.Right, val)
        } else {
            // 重复节点不插入，直接返回
            return node
        }
        // 更新节点高度
        t.updateHeight(node)
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = t.rotate(node)
        // 返回子树的根节点
        return node
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 插入节点 */
    func insert(val: Int) {
        root = insertHelper(node: root, val: val)
    }

    /* 递归插入节点（辅助方法） */
    func insertHelper(node: TreeNode?, val: Int) -> TreeNode? {
        var node = node
        if node == nil {
            return TreeNode(x: val)
        }
        /* 1. 查找插入位置并插入节点 */
        if val < node!.val {
            node?.left = insertHelper(node: node?.left, val: val)
        } else if val > node!.val {
            node?.right = insertHelper(node: node?.right, val: val)
        } else {
            return node // 重复节点不插入，直接返回
        }
        updateHeight(node: node) // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node: node)
        // 返回子树的根节点
        return node
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 插入节点 */
    insert(val) {
        this.root = this.#insertHelper(this.root, val);
    }

    /* 递归插入节点（辅助方法） */
    #insertHelper(node, val) {
        if (node === null) return new TreeNode(val);
        /* 1. 查找插入位置并插入节点 */
        if (val < node.val) node.left = this.#insertHelper(node.left, val);
        else if (val > node.val)
            node.right = this.#insertHelper(node.right, val);
        else return node; // 重复节点不插入，直接返回
        this.#updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = this.#rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 插入节点 */
    insert(val: number): void {
        this.root = this.insertHelper(this.root, val);
    }

    /* 递归插入节点（辅助方法） */
    insertHelper(node: TreeNode, val: number): TreeNode {
        if (node === null) return new TreeNode(val);
        /* 1. 查找插入位置并插入节点 */
        if (val < node.val) {
            node.left = this.insertHelper(node.left, val);
        } else if (val > node.val) {
            node.right = this.insertHelper(node.right, val);
        } else {
            return node; // 重复节点不插入，直接返回
        }
        this.updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = this.rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 插入节点 */
    void insert(int val) {
      root = insertHelper(root, val);
    }

    /* 递归插入节点（辅助方法） */
    TreeNode? insertHelper(TreeNode? node, int val) {
      if (node == null) return TreeNode(val);
      /* 1. 查找插入位置并插入节点 */
      if (val < node.val)
        node.left = insertHelper(node.left, val);
      else if (val > node.val)
        node.right = insertHelper(node.right, val);
      else
        return node; // 重复节点不插入，直接返回
      updateHeight(node); // 更新节点高度
      /* 2. 执行旋转操作，使该子树重新恢复平衡 */
      node = rotate(node);
      // 返回子树的根节点
      return node;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 插入节点 */
    fn insert(&mut self, val: i32) {
        self.root = Self::insert_helper(self.root.clone(), val);
    }

    /* 递归插入节点（辅助方法） */
    fn insert_helper(node: OptionTreeNodeRc, val: i32) -> OptionTreeNodeRc {
        match node {
            Some(mut node) => {
                /* 1. 查找插入位置并插入节点 */
                match {
                    let node_val = node.borrow().val;
                    node_val
                }
                .cmp(&val)
                {
                    Ordering::Greater => {
                        let left = node.borrow().left.clone();
                        node.borrow_mut().left = Self::insert_helper(left, val);
                    }
                    Ordering::Less => {
                        let right = node.borrow().right.clone();
                        node.borrow_mut().right = Self::insert_helper(right, val);
                    }
                    Ordering::Equal => {
                        return Some(node); // 重复节点不插入，直接返回
                    }
                }
                Self::update_height(Some(node.clone())); // 更新节点高度

                /* 2. 执行旋转操作，使该子树重新恢复平衡 */
                node = Self::rotate(Some(node)).unwrap();
                // 返回子树的根节点
                Some(node)
            }
            None => Some(TreeNode::new(val)),
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 插入节点 */
    void insert(AVLTree *tree, int val) {
        tree->root = insertHelper(tree->root, val);
    }

    /* 递归插入节点（辅助函数） */
    TreeNode *insertHelper(TreeNode *node, int val) {
        if (node == NULL) {
            return newTreeNode(val);
        }
        /* 1. 查找插入位置并插入节点 */
        if (val < node->val) {
            node->left = insertHelper(node->left, val);
        } else if (val > node->val) {
            node->right = insertHelper(node->right, val);
        } else {
            // 重复节点不插入，直接返回
            return node;
        }
        // 更新节点高度
        updateHeight(node);
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 插入节点 */
    fun insert(_val: Int) {
        root = insertHelper(root, _val)
    }

    /* 递归插入节点（辅助方法） */
    fun insertHelper(n: TreeNode?, _val: Int): TreeNode {
        if (n == null)
            return TreeNode(_val)
        var node = n
        /* 1. 查找插入位置并插入节点 */
        if (_val < node._val)
            node.left = insertHelper(node.left, _val)
        else if (_val > node._val)
            node.right = insertHelper(node.right, _val)
        else
            return node // 重复节点不插入，直接返回
        updateHeight(node) // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node)
        // 返回子树的根节点
        return node
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 插入节点 ###
    def insert(val)
      @root = insert_helper(@root, val)
    end

    ### 递归插入节点（辅助方法）###
    def insert_helper(node, val)
      return TreeNode.new(val) if node.nil?
      # 1. 查找插入位置并插入节点
      if val < node.val
        node.left = insert_helper(node.left, val)
      elsif val > node.val
        node.right = insert_helper(node.right, val)
      else
        # 重复节点不插入，直接返回
        return node
      end
      # 更新节点高度
      update_height(node)
      # 2. 执行旋转操作，使该子树重新恢复平衡
      rotate(node)
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 插入节点
    fn insert(self: *Self, val: T) !void {
        self.root = (try self.insertHelper(self.root, val)).?;
    }

    // 递归插入节点（辅助方法）
    fn insertHelper(self: *Self, node_: ?*inc.TreeNode(T), val: T) !?*inc.TreeNode(T) {
        var node = node_;
        if (node == null) {
            var tmp_node = try self.mem_allocator.create(inc.TreeNode(T));
            tmp_node.init(val);
            return tmp_node;
        }
        // 1. 查找插入位置并插入节点
        if (val < node.?.val) {
            node.?.left = try self.insertHelper(node.?.left, val);
        } else if (val > node.?.val) {
            node.?.right = try self.insertHelper(node.?.right, val);
        } else {
            return node;            // 重复节点不插入，直接返回
        }
        self.updateHeight(node);    // 更新节点高度
        // 2. 执行旋转操作，使该子树重新恢复平衡
        node = self.rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

### 2. &nbsp; 删除节点

类似地，在二叉搜索树的删除节点方法的基础上，需要从底至顶执行旋转操作，使所有失衡节点恢复平衡。代码如下所示：

=== "Python"

    ```python title="avl_tree.py"
    def remove(self, val: int):
        """删除节点"""
        self._root = self.remove_helper(self._root, val)

    def remove_helper(self, node: TreeNode | None, val: int) -> TreeNode | None:
        """递归删除节点（辅助方法）"""
        if node is None:
            return None
        # 1. 查找节点并删除
        if val < node.val:
            node.left = self.remove_helper(node.left, val)
        elif val > node.val:
            node.right = self.remove_helper(node.right, val)
        else:
            if node.left is None or node.right is None:
                child = node.left or node.right
                # 子节点数量 = 0 ，直接删除 node 并返回
                if child is None:
                    return None
                # 子节点数量 = 1 ，直接删除 node
                else:
                    node = child
            else:
                # 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                temp = node.right
                while temp.left is not None:
                    temp = temp.left
                node.right = self.remove_helper(node.right, temp.val)
                node.val = temp.val
        # 更新节点高度
        self.update_height(node)
        # 2. 执行旋转操作，使该子树重新恢复平衡
        return self.rotate(node)
    ```

=== "C++"

    ```cpp title="avl_tree.cpp"
    /* 删除节点 */
    void remove(int val) {
        root = removeHelper(root, val);
    }

    /* 递归删除节点（辅助方法） */
    TreeNode *removeHelper(TreeNode *node, int val) {
        if (node == nullptr)
            return nullptr;
        /* 1. 查找节点并删除 */
        if (val < node->val)
            node->left = removeHelper(node->left, val);
        else if (val > node->val)
            node->right = removeHelper(node->right, val);
        else {
            if (node->left == nullptr || node->right == nullptr) {
                TreeNode *child = node->left != nullptr ? node->left : node->right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == nullptr) {
                    delete node;
                    return nullptr;
                }
                // 子节点数量 = 1 ，直接删除 node
                else {
                    delete node;
                    node = child;
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                TreeNode *temp = node->right;
                while (temp->left != nullptr) {
                    temp = temp->left;
                }
                int tempVal = temp->val;
                node->right = removeHelper(node->right, temp->val);
                node->val = tempVal;
            }
        }
        updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Java"

    ```java title="avl_tree.java"
    /* 删除节点 */
    void remove(int val) {
        root = removeHelper(root, val);
    }

    /* 递归删除节点（辅助方法） */
    TreeNode removeHelper(TreeNode node, int val) {
        if (node == null)
            return null;
        /* 1. 查找节点并删除 */
        if (val < node.val)
            node.left = removeHelper(node.left, val);
        else if (val > node.val)
            node.right = removeHelper(node.right, val);
        else {
            if (node.left == null || node.right == null) {
                TreeNode child = node.left != null ? node.left : node.right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == null)
                    return null;
                // 子节点数量 = 1 ，直接删除 node
                else
                    node = child;
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                TreeNode temp = node.right;
                while (temp.left != null) {
                    temp = temp.left;
                }
                node.right = removeHelper(node.right, temp.val);
                node.val = temp.val;
            }
        }
        updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "C#"

    ```csharp title="avl_tree.cs"
    /* 删除节点 */
    void Remove(int val) {
        root = RemoveHelper(root, val);
    }

    /* 递归删除节点（辅助方法） */
    TreeNode? RemoveHelper(TreeNode? node, int val) {
        if (node == null) return null;
        /* 1. 查找节点并删除 */
        if (val < node.val)
            node.left = RemoveHelper(node.left, val);
        else if (val > node.val)
            node.right = RemoveHelper(node.right, val);
        else {
            if (node.left == null || node.right == null) {
                TreeNode? child = node.left ?? node.right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == null)
                    return null;
                // 子节点数量 = 1 ，直接删除 node
                else
                    node = child;
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                TreeNode? temp = node.right;
                while (temp.left != null) {
                    temp = temp.left;
                }
                node.right = RemoveHelper(node.right, temp.val!.Value);
                node.val = temp.val;
            }
        }
        UpdateHeight(node);  // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = Rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Go"

    ```go title="avl_tree.go"
    /* 删除节点 */
    func (t *aVLTree) remove(val int) {
        t.root = t.removeHelper(t.root, val)
    }

    /* 递归删除节点（辅助函数） */
    func (t *aVLTree) removeHelper(node *TreeNode, val int) *TreeNode {
        if node == nil {
            return nil
        }
        /* 1. 查找节点并删除 */
        if val < node.Val.(int) {
            node.Left = t.removeHelper(node.Left, val)
        } else if val > node.Val.(int) {
            node.Right = t.removeHelper(node.Right, val)
        } else {
            if node.Left == nil || node.Right == nil {
                child := node.Left
                if node.Right != nil {
                    child = node.Right
                }
                if child == nil {
                    // 子节点数量 = 0 ，直接删除 node 并返回
                    return nil
                } else {
                    // 子节点数量 = 1 ，直接删除 node
                    node = child
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                temp := node.Right
                for temp.Left != nil {
                    temp = temp.Left
                }
                node.Right = t.removeHelper(node.Right, temp.Val.(int))
                node.Val = temp.Val
            }
        }
        // 更新节点高度
        t.updateHeight(node)
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = t.rotate(node)
        // 返回子树的根节点
        return node
    }
    ```

=== "Swift"

    ```swift title="avl_tree.swift"
    /* 删除节点 */
    func remove(val: Int) {
        root = removeHelper(node: root, val: val)
    }

    /* 递归删除节点（辅助方法） */
    func removeHelper(node: TreeNode?, val: Int) -> TreeNode? {
        var node = node
        if node == nil {
            return nil
        }
        /* 1. 查找节点并删除 */
        if val < node!.val {
            node?.left = removeHelper(node: node?.left, val: val)
        } else if val > node!.val {
            node?.right = removeHelper(node: node?.right, val: val)
        } else {
            if node?.left == nil || node?.right == nil {
                let child = node?.left ?? node?.right
                // 子节点数量 = 0 ，直接删除 node 并返回
                if child == nil {
                    return nil
                }
                // 子节点数量 = 1 ，直接删除 node
                else {
                    node = child
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                var temp = node?.right
                while temp?.left != nil {
                    temp = temp?.left
                }
                node?.right = removeHelper(node: node?.right, val: temp!.val)
                node?.val = temp!.val
            }
        }
        updateHeight(node: node) // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node: node)
        // 返回子树的根节点
        return node
    }
    ```

=== "JS"

    ```javascript title="avl_tree.js"
    /* 删除节点 */
    remove(val) {
        this.root = this.#removeHelper(this.root, val);
    }

    /* 递归删除节点（辅助方法） */
    #removeHelper(node, val) {
        if (node === null) return null;
        /* 1. 查找节点并删除 */
        if (val < node.val) node.left = this.#removeHelper(node.left, val);
        else if (val > node.val)
            node.right = this.#removeHelper(node.right, val);
        else {
            if (node.left === null || node.right === null) {
                const child = node.left !== null ? node.left : node.right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child === null) return null;
                // 子节点数量 = 1 ，直接删除 node
                else node = child;
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                let temp = node.right;
                while (temp.left !== null) {
                    temp = temp.left;
                }
                node.right = this.#removeHelper(node.right, temp.val);
                node.val = temp.val;
            }
        }
        this.#updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = this.#rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "TS"

    ```typescript title="avl_tree.ts"
    /* 删除节点 */
    remove(val: number): void {
        this.root = this.removeHelper(this.root, val);
    }

    /* 递归删除节点（辅助方法） */
    removeHelper(node: TreeNode, val: number): TreeNode {
        if (node === null) return null;
        /* 1. 查找节点并删除 */
        if (val < node.val) {
            node.left = this.removeHelper(node.left, val);
        } else if (val > node.val) {
            node.right = this.removeHelper(node.right, val);
        } else {
            if (node.left === null || node.right === null) {
                const child = node.left !== null ? node.left : node.right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child === null) {
                    return null;
                } else {
                    // 子节点数量 = 1 ，直接删除 node
                    node = child;
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                let temp = node.right;
                while (temp.left !== null) {
                    temp = temp.left;
                }
                node.right = this.removeHelper(node.right, temp.val);
                node.val = temp.val;
            }
        }
        this.updateHeight(node); // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = this.rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Dart"

    ```dart title="avl_tree.dart"
    /* 删除节点 */
    void remove(int val) {
      root = removeHelper(root, val);
    }

    /* 递归删除节点（辅助方法） */
    TreeNode? removeHelper(TreeNode? node, int val) {
      if (node == null) return null;
      /* 1. 查找节点并删除 */
      if (val < node.val)
        node.left = removeHelper(node.left, val);
      else if (val > node.val)
        node.right = removeHelper(node.right, val);
      else {
        if (node.left == null || node.right == null) {
          TreeNode? child = node.left ?? node.right;
          // 子节点数量 = 0 ，直接删除 node 并返回
          if (child == null)
            return null;
          // 子节点数量 = 1 ，直接删除 node
          else
            node = child;
        } else {
          // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
          TreeNode? temp = node.right;
          while (temp!.left != null) {
            temp = temp.left;
          }
          node.right = removeHelper(node.right, temp.val);
          node.val = temp.val;
        }
      }
      updateHeight(node); // 更新节点高度
      /* 2. 执行旋转操作，使该子树重新恢复平衡 */
      node = rotate(node);
      // 返回子树的根节点
      return node;
    }
    ```

=== "Rust"

    ```rust title="avl_tree.rs"
    /* 删除节点 */
    fn remove(&self, val: i32) {
        Self::remove_helper(self.root.clone(), val);
    }

    /* 递归删除节点（辅助方法） */
    fn remove_helper(node: OptionTreeNodeRc, val: i32) -> OptionTreeNodeRc {
        match node {
            Some(mut node) => {
                /* 1. 查找节点并删除 */
                if val < node.borrow().val {
                    let left = node.borrow().left.clone();
                    node.borrow_mut().left = Self::remove_helper(left, val);
                } else if val > node.borrow().val {
                    let right = node.borrow().right.clone();
                    node.borrow_mut().right = Self::remove_helper(right, val);
                } else if node.borrow().left.is_none() || node.borrow().right.is_none() {
                    let child = if node.borrow().left.is_some() {
                        node.borrow().left.clone()
                    } else {
                        node.borrow().right.clone()
                    };
                    match child {
                        // 子节点数量 = 0 ，直接删除 node 并返回
                        None => {
                            return None;
                        }
                        // 子节点数量 = 1 ，直接删除 node
                        Some(child) => node = child,
                    }
                } else {
                    // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                    let mut temp = node.borrow().right.clone().unwrap();
                    loop {
                        let temp_left = temp.borrow().left.clone();
                        if temp_left.is_none() {
                            break;
                        }
                        temp = temp_left.unwrap();
                    }
                    let right = node.borrow().right.clone();
                    node.borrow_mut().right = Self::remove_helper(right, temp.borrow().val);
                    node.borrow_mut().val = temp.borrow().val;
                }
                Self::update_height(Some(node.clone())); // 更新节点高度

                /* 2. 执行旋转操作，使该子树重新恢复平衡 */
                node = Self::rotate(Some(node)).unwrap();
                // 返回子树的根节点
                Some(node)
            }
            None => None,
        }
    }
    ```

=== "C"

    ```c title="avl_tree.c"
    /* 删除节点 */
    // 由于引入了 stdio.h ，此处无法使用 remove 关键词
    void removeItem(AVLTree *tree, int val) {
        TreeNode *root = removeHelper(tree->root, val);
    }

    /* 递归删除节点（辅助函数） */
    TreeNode *removeHelper(TreeNode *node, int val) {
        TreeNode *child, *grandChild;
        if (node == NULL) {
            return NULL;
        }
        /* 1. 查找节点并删除 */
        if (val < node->val) {
            node->left = removeHelper(node->left, val);
        } else if (val > node->val) {
            node->right = removeHelper(node->right, val);
        } else {
            if (node->left == NULL || node->right == NULL) {
                child = node->left;
                if (node->right != NULL) {
                    child = node->right;
                }
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == NULL) {
                    return NULL;
                } else {
                    // 子节点数量 = 1 ，直接删除 node
                    node = child;
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                TreeNode *temp = node->right;
                while (temp->left != NULL) {
                    temp = temp->left;
                }
                int tempVal = temp->val;
                node->right = removeHelper(node->right, temp->val);
                node->val = tempVal;
            }
        }
        // 更新节点高度
        updateHeight(node);
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

=== "Kotlin"

    ```kotlin title="avl_tree.kt"
    /* 删除节点 */
    fun remove(_val: Int) {
        root = removeHelper(root, _val)
    }

    /* 递归删除节点（辅助方法） */
    fun removeHelper(n: TreeNode?, _val: Int): TreeNode? {
        var node = n ?: return null
        /* 1. 查找节点并删除 */
        if (_val < node._val)
            node.left = removeHelper(node.left, _val)
        else if (_val > node._val)
            node.right = removeHelper(node.right, _val)
        else {
            if (node.left == null || node.right == null) {
                val child = if (node.left != null)
                    node.left
                else
                    node.right
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == null)
                    return null
                // 子节点数量 = 1 ，直接删除 node
                else
                    node = child
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                var temp = node.right
                while (temp!!.left != null) {
                    temp = temp.left
                }
                node.right = removeHelper(node.right, temp._val)
                node._val = temp._val
            }
        }
        updateHeight(node) // 更新节点高度
        /* 2. 执行旋转操作，使该子树重新恢复平衡 */
        node = rotate(node)
        // 返回子树的根节点
        return node
    }
    ```

=== "Ruby"

    ```ruby title="avl_tree.rb"
    ### 删除节点 ###
    def remove(val)
      @root = remove_helper(@root, val)
    end

    ### 递归删除节点（辅助方法）###
    def remove_helper(node, val)
      return if node.nil?
      # 1. 查找节点并删除
      if val < node.val
        node.left = remove_helper(node.left, val)
      elsif val > node.val
        node.right = remove_helper(node.right, val)
      else
        if node.left.nil? || node.right.nil?
          child = node.left || node.right
          # 子节点数量 = 0 ，直接删除 node 并返回
          return if child.nil?
          # 子节点数量 = 1 ，直接删除 node
          node = child
        else
          # 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
          temp = node.right
          while !temp.left.nil?
            temp = temp.left
          end
          node.right = remove_helper(node.right, temp.val)
          node.val = temp.val
        end
      end
      # 更新节点高度
      update_height(node)
      # 2. 执行旋转操作，使该子树重新恢复平衡
      rotate(node)
    end
    ```

=== "Zig"

    ```zig title="avl_tree.zig"
    // 删除节点
    fn remove(self: *Self, val: T) void {
       self.root = self.removeHelper(self.root, val).?;
    }

    // 递归删除节点（辅助方法）
    fn removeHelper(self: *Self, node_: ?*inc.TreeNode(T), val: T) ?*inc.TreeNode(T) {
        var node = node_;
        if (node == null) return null;
        // 1. 查找节点并删除
        if (val < node.?.val) {
            node.?.left = self.removeHelper(node.?.left, val);
        } else if (val > node.?.val) {
            node.?.right = self.removeHelper(node.?.right, val);
        } else {
            if (node.?.left == null or node.?.right == null) {
                var child = if (node.?.left != null) node.?.left else node.?.right;
                // 子节点数量 = 0 ，直接删除 node 并返回
                if (child == null) {
                    return null;
                // 子节点数量 = 1 ，直接删除 node
                } else {
                    node = child;
                }
            } else {
                // 子节点数量 = 2 ，则将中序遍历的下个节点删除，并用该节点替换当前节点
                var temp = node.?.right;
                while (temp.?.left != null) {
                    temp = temp.?.left;
                }
                node.?.right = self.removeHelper(node.?.right, temp.?.val);
                node.?.val = temp.?.val;
            }
        }
        self.updateHeight(node); // 更新节点高度
        // 2. 执行旋转操作，使该子树重新恢复平衡
        node = self.rotate(node);
        // 返回子树的根节点
        return node;
    }
    ```

### 3. &nbsp; 查找节点

AVL 树的节点查找操作与二叉搜索树一致，在此不再赘述。

## 7.5.4 &nbsp; AVL 树典型应用

- 组织和存储大型数据，适用于高频查找、低频增删的场景。
- 用于构建数据库中的索引系统。
- 红黑树也是一种常见的平衡二叉搜索树。相较于 AVL 树，红黑树的平衡条件更宽松，插入与删除节点所需的旋转操作更少，节点增删操作的平均效率更高。
