---
comments: true
---

# 11.5 &nbsp; 快速排序

<u>快速排序（quick sort）</u>是一种基于分治策略的排序算法，运行高效，应用广泛。

快速排序的核心操作是“哨兵划分”，其目标是：选择数组中的某个元素作为“基准数”，将所有小于基准数的元素移到其左侧，而大于基准数的元素移到其右侧。具体来说，哨兵划分的流程如图 11-8 所示。

1. 选取数组最左端元素作为基准数，初始化两个指针 `i` 和 `j` 分别指向数组的两端。
2. 设置一个循环，在每轮中使用 `i`（`j`）分别寻找第一个比基准数大（小）的元素，然后交换这两个元素。
3. 循环执行步骤 `2.` ，直到 `i` 和 `j` 相遇时停止，最后将基准数交换至两个子数组的分界线。

=== "<1>"
    ![哨兵划分步骤](quick_sort.assets/pivot_division_step1.png){ class="animation-figure" }

=== "<2>"
    ![pivot_division_step2](quick_sort.assets/pivot_division_step2.png){ class="animation-figure" }

=== "<3>"
    ![pivot_division_step3](quick_sort.assets/pivot_division_step3.png){ class="animation-figure" }

=== "<4>"
    ![pivot_division_step4](quick_sort.assets/pivot_division_step4.png){ class="animation-figure" }

=== "<5>"
    ![pivot_division_step5](quick_sort.assets/pivot_division_step5.png){ class="animation-figure" }

=== "<6>"
    ![pivot_division_step6](quick_sort.assets/pivot_division_step6.png){ class="animation-figure" }

=== "<7>"
    ![pivot_division_step7](quick_sort.assets/pivot_division_step7.png){ class="animation-figure" }

=== "<8>"
    ![pivot_division_step8](quick_sort.assets/pivot_division_step8.png){ class="animation-figure" }

=== "<9>"
    ![pivot_division_step9](quick_sort.assets/pivot_division_step9.png){ class="animation-figure" }

<p align="center"> 图 11-8 &nbsp; 哨兵划分步骤 </p>

哨兵划分完成后，原数组被划分成三部分：左子数组、基准数、右子数组，且满足“左子数组任意元素 $\leq$ 基准数 $\leq$ 右子数组任意元素”。因此，我们接下来只需对这两个子数组进行排序。

!!! note "快速排序的分治策略"

    哨兵划分的实质是将一个较长数组的排序问题简化为两个较短数组的排序问题。

=== "Python"

    ```python title="quick_sort.py"
    def partition(self, nums: list[int], left: int, right: int) -> int:
        """哨兵划分"""
        # 以 nums[left] 为基准数
        i, j = left, right
        while i < j:
            while i < j and nums[j] >= nums[left]:
                j -= 1  # 从右向左找首个小于基准数的元素
            while i < j and nums[i] <= nums[left]:
                i += 1  # 从左向右找首个大于基准数的元素
            # 元素交换
            nums[i], nums[j] = nums[j], nums[i]
        # 将基准数交换至两子数组的分界线
        nums[i], nums[left] = nums[left], nums[i]
        return i  # 返回基准数的索引
    ```

=== "C++"

    ```cpp title="quick_sort.cpp"
    /* 哨兵划分 */
    int partition(vector<int> &nums, int left, int right) {
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;                // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;                // 从左向右找首个大于基准数的元素
            swap(nums[i], nums[j]); // 交换这两个元素
        }
        swap(nums[i], nums[left]);  // 将基准数交换至两子数组的分界线
        return i;                   // 返回基准数的索引
    }
    ```

=== "Java"

    ```java title="quick_sort.java"
    /* 元素交换 */
    void swap(int[] nums, int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    /* 哨兵划分 */
    int partition(int[] nums, int left, int right) {
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;          // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;          // 从左向右找首个大于基准数的元素
            swap(nums, i, j); // 交换这两个元素
        }
        swap(nums, i, left);  // 将基准数交换至两子数组的分界线
        return i;             // 返回基准数的索引
    }
    ```

=== "C#"

    ```csharp title="quick_sort.cs"
    /* 元素交换 */
    void Swap(int[] nums, int i, int j) {
        (nums[j], nums[i]) = (nums[i], nums[j]);
    }

    /* 哨兵划分 */
    int Partition(int[] nums, int left, int right) {
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;          // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;          // 从左向右找首个大于基准数的元素
            Swap(nums, i, j); // 交换这两个元素
        }
        Swap(nums, i, left);  // 将基准数交换至两子数组的分界线
        return i;             // 返回基准数的索引
    }
    ```

=== "Go"

    ```go title="quick_sort.go"
    /* 哨兵划分 */
    func (q *quickSort) partition(nums []int, left, right int) int {
        // 以 nums[left] 为基准数
        i, j := left, right
        for i < j {
            for i < j && nums[j] >= nums[left] {
                j-- // 从右向左找首个小于基准数的元素
            }
            for i < j && nums[i] <= nums[left] {
                i++ // 从左向右找首个大于基准数的元素
            }
            // 元素交换
            nums[i], nums[j] = nums[j], nums[i]
        }
        // 将基准数交换至两子数组的分界线
        nums[i], nums[left] = nums[left], nums[i]
        return i // 返回基准数的索引
    }
    ```

=== "Swift"

    ```swift title="quick_sort.swift"
    /* 哨兵划分 */
    func partition(nums: inout [Int], left: Int, right: Int) -> Int {
        // 以 nums[left] 为基准数
        var i = left
        var j = right
        while i < j {
            while i < j, nums[j] >= nums[left] {
                j -= 1 // 从右向左找首个小于基准数的元素
            }
            while i < j, nums[i] <= nums[left] {
                i += 1 // 从左向右找首个大于基准数的元素
            }
            nums.swapAt(i, j) // 交换这两个元素
        }
        nums.swapAt(i, left) // 将基准数交换至两子数组的分界线
        return i // 返回基准数的索引
    }
    ```

=== "JS"

    ```javascript title="quick_sort.js"
    /* 元素交换 */
    swap(nums, i, j) {
        let tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    /* 哨兵划分 */
    partition(nums, left, right) {
        // 以 nums[left] 为基准数
        let i = left,
            j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left]) {
                j -= 1; // 从右向左找首个小于基准数的元素
            }
            while (i < j && nums[i] <= nums[left]) {
                i += 1; // 从左向右找首个大于基准数的元素
            }
            // 元素交换
            this.swap(nums, i, j); // 交换这两个元素
        }
        this.swap(nums, i, left); // 将基准数交换至两子数组的分界线
        return i; // 返回基准数的索引
    }
    ```

=== "TS"

    ```typescript title="quick_sort.ts"
    /* 元素交换 */
    swap(nums: number[], i: number, j: number): void {
        let tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    /* 哨兵划分 */
    partition(nums: number[], left: number, right: number): number {
        // 以 nums[left] 为基准数
        let i = left,
            j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left]) {
                j -= 1; // 从右向左找首个小于基准数的元素
            }
            while (i < j && nums[i] <= nums[left]) {
                i += 1; // 从左向右找首个大于基准数的元素
            }
            // 元素交换
            this.swap(nums, i, j); // 交换这两个元素
        }
        this.swap(nums, i, left); // 将基准数交换至两子数组的分界线
        return i; // 返回基准数的索引
    }
    ```

=== "Dart"

    ```dart title="quick_sort.dart"
    /* 元素交换 */
    void _swap(List<int> nums, int i, int j) {
      int tmp = nums[i];
      nums[i] = nums[j];
      nums[j] = tmp;
    }

    /* 哨兵划分 */
    int _partition(List<int> nums, int left, int right) {
      // 以 nums[left] 为基准数
      int i = left, j = right;
      while (i < j) {
        while (i < j && nums[j] >= nums[left]) j--; // 从右向左找首个小于基准数的元素
        while (i < j && nums[i] <= nums[left]) i++; // 从左向右找首个大于基准数的元素
        _swap(nums, i, j); // 交换这两个元素
      }
      _swap(nums, i, left); // 将基准数交换至两子数组的分界线
      return i; // 返回基准数的索引
    }
    ```

=== "Rust"

    ```rust title="quick_sort.rs"
    /* 哨兵划分 */
    fn partition(nums: &mut [i32], left: usize, right: usize) -> usize {
        // 以 nums[left] 为基准数
        let (mut i, mut j) = (left, right);
        while i < j {
            while i < j && nums[j] >= nums[left] {
                j -= 1; // 从右向左找首个小于基准数的元素
            }
            while i < j && nums[i] <= nums[left] {
                i += 1; // 从左向右找首个大于基准数的元素
            }
            nums.swap(i, j); // 交换这两个元素
        }
        nums.swap(i, left); // 将基准数交换至两子数组的分界线
        i // 返回基准数的索引
    }
    ```

=== "C"

    ```c title="quick_sort.c"
    /* 元素交换 */
    void swap(int nums[], int i, int j) {
        int tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    /* 哨兵划分 */
    int partition(int nums[], int left, int right) {
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left]) {
                j--; // 从右向左找首个小于基准数的元素
            }
            while (i < j && nums[i] <= nums[left]) {
                i++; // 从左向右找首个大于基准数的元素
            }
            // 交换这两个元素
            swap(nums, i, j);
        }
        // 将基准数交换至两子数组的分界线
        swap(nums, i, left);
        // 返回基准数的索引
        return i;
    }
    ```

=== "Kotlin"

    ```kotlin title="quick_sort.kt"
    /* 元素交换 */
    fun swap(nums: IntArray, i: Int, j: Int) {
        val temp = nums[i]
        nums[i] = nums[j]
        nums[j] = temp
    }

    /* 哨兵划分 */
    fun partition(nums: IntArray, left: Int, right: Int): Int {
        // 以 nums[left] 为基准数
        var i = left
        var j = right
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--           // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++           // 从左向右找首个大于基准数的元素
            swap(nums, i, j)  // 交换这两个元素
        }
        swap(nums, i, left)   // 将基准数交换至两子数组的分界线
        return i              // 返回基准数的索引
    }
    ```

=== "Ruby"

    ```ruby title="quick_sort.rb"
    ### 哨兵划分 ###
    def partition(nums, left, right)
      # 以 nums[left] 为基准数
      i, j = left, right
      while i < j
        while i < j && nums[j] >= nums[left]
          j -= 1 # 从右向左找首个小于基准数的元素
        end
        while i < j && nums[i] <= nums[left]
          i += 1 # 从左向右找首个大于基准数的元素
        end
        # 元素交换
        nums[i], nums[j] = nums[j], nums[i]
      end
      # 将基准数交换至两子数组的分界线
      nums[i], nums[left] = nums[left], nums[i]
      i # 返回基准数的索引
    end
    ```

=== "Zig"

    ```zig title="quick_sort.zig"
    // 元素交换
    fn swap(nums: []i32, i: usize, j: usize) void {
        var tmp = nums[i];
        nums[i] = nums[j];
        nums[j] = tmp;
    }

    // 哨兵划分
    fn partition(nums: []i32, left: usize, right: usize) usize {
        // 以 nums[left] 为基准数
        var i = left;
        var j = right;
        while (i < j) {
            while (i < j and nums[j] >= nums[left]) j -= 1; // 从右向左找首个小于基准数的元素
            while (i < j and nums[i] <= nums[left]) i += 1; // 从左向右找首个大于基准数的元素
            swap(nums, i, j);   // 交换这两个元素
        }
        swap(nums, i, left);    // 将基准数交换至两子数组的分界线
        return i;               // 返回基准数的索引
    }
    ```

??? pythontutor "可视化运行"

    <div style="height: 549px; width: 100%;"><iframe class="pythontutor-iframe" src="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20partition%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=472&codeDivWidth=350&cumulative=false&curInstr=4&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false"> </iframe></div>
    <div style="margin-top: 5px;"><a href="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20partition%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=800&codeDivWidth=600&cumulative=false&curInstr=4&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false" target="_blank" rel="noopener noreferrer">全屏观看 ></a></div>

## 11.5.1 &nbsp; 算法流程

快速排序的整体流程如图 11-9 所示。

1. 首先，对原数组执行一次“哨兵划分”，得到未排序的左子数组和右子数组。
2. 然后，对左子数组和右子数组分别递归执行“哨兵划分”。
3. 持续递归，直至子数组长度为 1 时终止，从而完成整个数组的排序。

![快速排序流程](quick_sort.assets/quick_sort_overview.png){ class="animation-figure" }

<p align="center"> 图 11-9 &nbsp; 快速排序流程 </p>

=== "Python"

    ```python title="quick_sort.py"
    def quick_sort(self, nums: list[int], left: int, right: int):
        """快速排序"""
        # 子数组长度为 1 时终止递归
        if left >= right:
            return
        # 哨兵划分
        pivot = self.partition(nums, left, right)
        # 递归左子数组、右子数组
        self.quick_sort(nums, left, pivot - 1)
        self.quick_sort(nums, pivot + 1, right)
    ```

=== "C++"

    ```cpp title="quick_sort.cpp"
    /* 快速排序 */
    void quickSort(vector<int> &nums, int left, int right) {
        // 子数组长度为 1 时终止递归
        if (left >= right)
            return;
        // 哨兵划分
        int pivot = partition(nums, left, right);
        // 递归左子数组、右子数组
        quickSort(nums, left, pivot - 1);
        quickSort(nums, pivot + 1, right);
    }
    ```

=== "Java"

    ```java title="quick_sort.java"
    /* 快速排序 */
    void quickSort(int[] nums, int left, int right) {
        // 子数组长度为 1 时终止递归
        if (left >= right)
            return;
        // 哨兵划分
        int pivot = partition(nums, left, right);
        // 递归左子数组、右子数组
        quickSort(nums, left, pivot - 1);
        quickSort(nums, pivot + 1, right);
    }
    ```

=== "C#"

    ```csharp title="quick_sort.cs"
    /* 快速排序 */
    void QuickSort(int[] nums, int left, int right) {
        // 子数组长度为 1 时终止递归
        if (left >= right)
            return;
        // 哨兵划分
        int pivot = Partition(nums, left, right);
        // 递归左子数组、右子数组
        QuickSort(nums, left, pivot - 1);
        QuickSort(nums, pivot + 1, right);
    }
    ```

=== "Go"

    ```go title="quick_sort.go"
    /* 快速排序 */
    func (q *quickSort) quickSort(nums []int, left, right int) {
        // 子数组长度为 1 时终止递归
        if left >= right {
            return
        }
        // 哨兵划分
        pivot := q.partition(nums, left, right)
        // 递归左子数组、右子数组
        q.quickSort(nums, left, pivot-1)
        q.quickSort(nums, pivot+1, right)
    }
    ```

=== "Swift"

    ```swift title="quick_sort.swift"
    /* 快速排序 */
    func quickSort(nums: inout [Int], left: Int, right: Int) {
        // 子数组长度为 1 时终止递归
        if left >= right {
            return
        }
        // 哨兵划分
        let pivot = partition(nums: &nums, left: left, right: right)
        // 递归左子数组、右子数组
        quickSort(nums: &nums, left: left, right: pivot - 1)
        quickSort(nums: &nums, left: pivot + 1, right: right)
    }
    ```

=== "JS"

    ```javascript title="quick_sort.js"
    /* 快速排序 */
    quickSort(nums, left, right) {
        // 子数组长度为 1 时终止递归
        if (left >= right) return;
        // 哨兵划分
        const pivot = this.partition(nums, left, right);
        // 递归左子数组、右子数组
        this.quickSort(nums, left, pivot - 1);
        this.quickSort(nums, pivot + 1, right);
    }
    ```

=== "TS"

    ```typescript title="quick_sort.ts"
    /* 快速排序 */
    quickSort(nums: number[], left: number, right: number): void {
        // 子数组长度为 1 时终止递归
        if (left >= right) {
            return;
        }
        // 哨兵划分
        const pivot = this.partition(nums, left, right);
        // 递归左子数组、右子数组
        this.quickSort(nums, left, pivot - 1);
        this.quickSort(nums, pivot + 1, right);
    }
    ```

=== "Dart"

    ```dart title="quick_sort.dart"
    /* 快速排序 */
    void quickSort(List<int> nums, int left, int right) {
      // 子数组长度为 1 时终止递归
      if (left >= right) return;
      // 哨兵划分
      int pivot = _partition(nums, left, right);
      // 递归左子数组、右子数组
      quickSort(nums, left, pivot - 1);
      quickSort(nums, pivot + 1, right);
    }
    ```

=== "Rust"

    ```rust title="quick_sort.rs"
    /* 快速排序 */
    pub fn quick_sort(left: i32, right: i32, nums: &mut [i32]) {
        // 子数组长度为 1 时终止递归
        if left >= right {
            return;
        }
        // 哨兵划分
        let pivot = Self::partition(nums, left as usize, right as usize) as i32;
        // 递归左子数组、右子数组
        Self::quick_sort(left, pivot - 1, nums);
        Self::quick_sort(pivot + 1, right, nums);
    }
    ```

=== "C"

    ```c title="quick_sort.c"
    /* 快速排序 */
    void quickSort(int nums[], int left, int right) {
        // 子数组长度为 1 时终止递归
        if (left >= right) {
            return;
        }
        // 哨兵划分
        int pivot = partition(nums, left, right);
        // 递归左子数组、右子数组
        quickSort(nums, left, pivot - 1);
        quickSort(nums, pivot + 1, right);
    }
    ```

=== "Kotlin"

    ```kotlin title="quick_sort.kt"
    /* 快速排序 */
    fun quickSort(nums: IntArray, left: Int, right: Int) {
        // 子数组长度为 1 时终止递归
        if (left >= right) return
        // 哨兵划分
        val pivot = partition(nums, left, right)
        // 递归左子数组、右子数组
        quickSort(nums, left, pivot - 1)
        quickSort(nums, pivot + 1, right)
    }
    ```

=== "Ruby"

    ```ruby title="quick_sort.rb"
    ### 快速排序类 ###
    def quick_sort(nums, left, right)
      # 子数组长度不为 1 时递归
      if left < right
        # 哨兵划分
        pivot = partition(nums, left, right)
        # 递归左子数组、右子数组
        quick_sort(nums, left, pivot - 1)
        quick_sort(nums, pivot + 1, right)
      end
      nums
    end
    ```

=== "Zig"

    ```zig title="quick_sort.zig"
    // 快速排序
    fn quickSort(nums: []i32, left: usize, right: usize) void {
        // 子数组长度为 1 时终止递归
        if (left >= right) return;
        // 哨兵划分
        var pivot = partition(nums, left, right);
        // 递归左子数组、右子数组
        quickSort(nums, left, pivot - 1);
        quickSort(nums, pivot + 1, right);
    }
    ```

??? pythontutor "可视化运行"

    <div style="height: 549px; width: 100%;"><iframe class="pythontutor-iframe" src="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0Adef%20quick_sort%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%3A%0A%20%20%20%20%22%22%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%22%22%22%0A%20%20%20%20%23%20%E5%AD%90%E6%95%B0%E7%BB%84%E9%95%BF%E5%BA%A6%E4%B8%BA%201%20%E6%97%B6%E7%BB%88%E6%AD%A2%E9%80%92%E5%BD%92%0A%20%20%20%20if%20left%20%3E%3D%20right%3A%0A%20%20%20%20%20%20%20%20return%0A%20%20%20%20%23%20%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%0A%20%20%20%20pivot%20%3D%20partition%28nums,%20left,%20right%29%0A%20%20%20%20%23%20%E9%80%92%E5%BD%92%E5%B7%A6%E5%AD%90%E6%95%B0%E7%BB%84%E3%80%81%E5%8F%B3%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20quick_sort%28nums,%20left,%20pivot%20-%201%29%0A%20%20%20%20quick_sort%28nums,%20pivot%20%2B%201,%20right%29%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20quick_sort%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=472&codeDivWidth=350&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false"> </iframe></div>
    <div style="margin-top: 5px;"><a href="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0Adef%20quick_sort%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%3A%0A%20%20%20%20%22%22%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%22%22%22%0A%20%20%20%20%23%20%E5%AD%90%E6%95%B0%E7%BB%84%E9%95%BF%E5%BA%A6%E4%B8%BA%201%20%E6%97%B6%E7%BB%88%E6%AD%A2%E9%80%92%E5%BD%92%0A%20%20%20%20if%20left%20%3E%3D%20right%3A%0A%20%20%20%20%20%20%20%20return%0A%20%20%20%20%23%20%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%0A%20%20%20%20pivot%20%3D%20partition%28nums,%20left,%20right%29%0A%20%20%20%20%23%20%E9%80%92%E5%BD%92%E5%B7%A6%E5%AD%90%E6%95%B0%E7%BB%84%E3%80%81%E5%8F%B3%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20quick_sort%28nums,%20left,%20pivot%20-%201%29%0A%20%20%20%20quick_sort%28nums,%20pivot%20%2B%201,%20right%29%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20quick_sort%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=800&codeDivWidth=600&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false" target="_blank" rel="noopener noreferrer">全屏观看 ></a></div>

## 11.5.2 &nbsp; 算法特性

- **时间复杂度为 $O(n \log n)$、非自适应排序**：在平均情况下，哨兵划分的递归层数为 $\log n$ ，每层中的总循环数为 $n$ ，总体使用 $O(n \log n)$ 时间。在最差情况下，每轮哨兵划分操作都将长度为 $n$ 的数组划分为长度为 $0$ 和 $n - 1$ 的两个子数组，此时递归层数达到 $n$ ，每层中的循环数为 $n$ ，总体使用 $O(n^2)$ 时间。
- **空间复杂度为 $O(n)$、原地排序**：在输入数组完全倒序的情况下，达到最差递归深度 $n$ ，使用 $O(n)$ 栈帧空间。排序操作是在原数组上进行的，未借助额外数组。
- **非稳定排序**：在哨兵划分的最后一步，基准数可能会被交换至相等元素的右侧。

## 11.5.3 &nbsp; 快速排序为什么快

从名称上就能看出，快速排序在效率方面应该具有一定的优势。尽管快速排序的平均时间复杂度与“归并排序”和“堆排序”相同，但通常快速排序的效率更高，主要有以下原因。

- **出现最差情况的概率很低**：虽然快速排序的最差时间复杂度为 $O(n^2)$ ，没有归并排序稳定，但在绝大多数情况下，快速排序能在 $O(n \log n)$ 的时间复杂度下运行。
- **缓存使用效率高**：在执行哨兵划分操作时，系统可将整个子数组加载到缓存，因此访问元素的效率较高。而像“堆排序”这类算法需要跳跃式访问元素，从而缺乏这一特性。
- **复杂度的常数系数小**：在上述三种算法中，快速排序的比较、赋值、交换等操作的总数量最少。这与“插入排序”比“冒泡排序”更快的原因类似。

## 11.5.4 &nbsp; 基准数优化

**快速排序在某些输入下的时间效率可能降低**。举一个极端例子，假设输入数组是完全倒序的，由于我们选择最左端元素作为基准数，那么在哨兵划分完成后，基准数被交换至数组最右端，导致左子数组长度为 $n - 1$、右子数组长度为 $0$ 。如此递归下去，每轮哨兵划分后都有一个子数组的长度为 $0$ ，分治策略失效，快速排序退化为“冒泡排序”的近似形式。

为了尽量避免这种情况发生，**我们可以优化哨兵划分中的基准数的选取策略**。例如，我们可以随机选取一个元素作为基准数。然而，如果运气不佳，每次都选到不理想的基准数，效率仍然不尽如人意。

需要注意的是，编程语言通常生成的是“伪随机数”。如果我们针对伪随机数序列构建一个特定的测试样例，那么快速排序的效率仍然可能劣化。

为了进一步改进，我们可以在数组中选取三个候选元素（通常为数组的首、尾、中点元素），**并将这三个候选元素的中位数作为基准数**。这样一来，基准数“既不太小也不太大”的概率将大幅提升。当然，我们还可以选取更多候选元素，以进一步提高算法的稳健性。采用这种方法后，时间复杂度劣化至 $O(n^2)$ 的概率大大降低。

示例代码如下：

=== "Python"

    ```python title="quick_sort.py"
    def median_three(self, nums: list[int], left: int, mid: int, right: int) -> int:
        """选取三个候选元素的中位数"""
        l, m, r = nums[left], nums[mid], nums[right]
        if (l <= m <= r) or (r <= m <= l):
            return mid  # m 在 l 和 r 之间
        if (m <= l <= r) or (r <= l <= m):
            return left  # l 在 m 和 r 之间
        return right

    def partition(self, nums: list[int], left: int, right: int) -> int:
        """哨兵划分（三数取中值）"""
        # 以 nums[left] 为基准数
        med = self.median_three(nums, left, (left + right) // 2, right)
        # 将中位数交换至数组最左端
        nums[left], nums[med] = nums[med], nums[left]
        # 以 nums[left] 为基准数
        i, j = left, right
        while i < j:
            while i < j and nums[j] >= nums[left]:
                j -= 1  # 从右向左找首个小于基准数的元素
            while i < j and nums[i] <= nums[left]:
                i += 1  # 从左向右找首个大于基准数的元素
            # 元素交换
            nums[i], nums[j] = nums[j], nums[i]
        # 将基准数交换至两子数组的分界线
        nums[i], nums[left] = nums[left], nums[i]
        return i  # 返回基准数的索引
    ```

=== "C++"

    ```cpp title="quick_sort.cpp"
    /* 选取三个候选元素的中位数 */
    int medianThree(vector<int> &nums, int left, int mid, int right) {
        int l = nums[left], m = nums[mid], r = nums[right];
        if ((l <= m && m <= r) || (r <= m && m <= l))
            return mid; // m 在 l 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m))
            return left; // l 在 m 和 r 之间
        return right;
    }

    /* 哨兵划分（三数取中值） */
    int partition(vector<int> &nums, int left, int right) {
        // 选取三个候选元素的中位数
        int med = medianThree(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        swap(nums[left], nums[med]);
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;                // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;                // 从左向右找首个大于基准数的元素
            swap(nums[i], nums[j]); // 交换这两个元素
        }
        swap(nums[i], nums[left]);  // 将基准数交换至两子数组的分界线
        return i;                   // 返回基准数的索引
    }
    ```

=== "Java"

    ```java title="quick_sort.java"
    /* 选取三个候选元素的中位数 */
    int medianThree(int[] nums, int left, int mid, int right) {
        int l = nums[left], m = nums[mid], r = nums[right];
        if ((l <= m && m <= r) || (r <= m && m <= l))
            return mid; // m 在 l 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m))
            return left; // l 在 m 和 r 之间
        return right;
    }

    /* 哨兵划分（三数取中值） */
    int partition(int[] nums, int left, int right) {
        // 选取三个候选元素的中位数
        int med = medianThree(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        swap(nums, left, med);
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;          // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;          // 从左向右找首个大于基准数的元素
            swap(nums, i, j); // 交换这两个元素
        }
        swap(nums, i, left);  // 将基准数交换至两子数组的分界线
        return i;             // 返回基准数的索引
    }
    ```

=== "C#"

    ```csharp title="quick_sort.cs"
    /* 选取三个候选元素的中位数 */
    int MedianThree(int[] nums, int left, int mid, int right) {
        int l = nums[left], m = nums[mid], r = nums[right];
        if ((l <= m && m <= r) || (r <= m && m <= l))
            return mid; // m 在 l 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m))
            return left; // l 在 m 和 r 之间
        return right;
    }

    /* 哨兵划分（三数取中值） */
    int Partition(int[] nums, int left, int right) {
        // 选取三个候选元素的中位数
        int med = MedianThree(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        Swap(nums, left, med);
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--;          // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;          // 从左向右找首个大于基准数的元素
            Swap(nums, i, j); // 交换这两个元素
        }
        Swap(nums, i, left);  // 将基准数交换至两子数组的分界线
        return i;             // 返回基准数的索引
    }
    ```

=== "Go"

    ```go title="quick_sort.go"
    /* 选取三个候选元素的中位数 */
    func (q *quickSortMedian) medianThree(nums []int, left, mid, right int) int {
        l, m, r := nums[left], nums[mid], nums[right]
        if (l <= m && m <= r) || (r <= m && m <= l) {
            return mid // m 在 l 和 r 之间
        }
        if (m <= l && l <= r) || (r <= l && l <= m) {
            return left // l 在 m 和 r 之间
        }
        return right
    }

    /* 哨兵划分（三数取中值）*/
    func (q *quickSortMedian) partition(nums []int, left, right int) int {
        // 以 nums[left] 为基准数
        med := q.medianThree(nums, left, (left+right)/2, right)
        // 将中位数交换至数组最左端
        nums[left], nums[med] = nums[med], nums[left]
        // 以 nums[left] 为基准数
        i, j := left, right
        for i < j {
            for i < j && nums[j] >= nums[left] {
                j-- //从右向左找首个小于基准数的元素
            }
            for i < j && nums[i] <= nums[left] {
                i++ //从左向右找首个大于基准数的元素
            }
            //元素交换
            nums[i], nums[j] = nums[j], nums[i]
        }
        //将基准数交换至两子数组的分界线
        nums[i], nums[left] = nums[left], nums[i]
        return i //返回基准数的索引
    }
    ```

=== "Swift"

    ```swift title="quick_sort.swift"
    /* 选取三个候选元素的中位数 */
    func medianThree(nums: [Int], left: Int, mid: Int, right: Int) -> Int {
        let l = nums[left]
        let m = nums[mid]
        let r = nums[right]
        if (l <= m && m <= r) || (r <= m && m <= l) {
            return mid // m 在 l 和 r 之间
        }
        if (m <= l && l <= r) || (r <= l && l <= m) {
            return left // l 在 m 和 r 之间
        }
        return right
    }

    /* 哨兵划分（三数取中值） */
    func partitionMedian(nums: inout [Int], left: Int, right: Int) -> Int {
        // 选取三个候选元素的中位数
        let med = medianThree(nums: nums, left: left, mid: left + (right - left) / 2, right: right)
        // 将中位数交换至数组最左端
        nums.swapAt(left, med)
        return partition(nums: &nums, left: left, right: right)
    }
    ```

=== "JS"

    ```javascript title="quick_sort.js"
    /* 选取三个候选元素的中位数 */
    medianThree(nums, left, mid, right) {
        let l = nums[left],
            m = nums[mid],
            r = nums[right];
        // m 在 l 和 r 之间
        if ((l <= m && m <= r) || (r <= m && m <= l)) return mid;
        // l 在 m 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m)) return left;
        return right;
    }

    /* 哨兵划分（三数取中值） */
    partition(nums, left, right) {
        // 选取三个候选元素的中位数
        let med = this.medianThree(
            nums,
            left,
            Math.floor((left + right) / 2),
            right
        );
        // 将中位数交换至数组最左端
        this.swap(nums, left, med);
        // 以 nums[left] 为基准数
        let i = left,
            j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left]) j--; // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left]) i++; // 从左向右找首个大于基准数的元素
            this.swap(nums, i, j); // 交换这两个元素
        }
        this.swap(nums, i, left); // 将基准数交换至两子数组的分界线
        return i; // 返回基准数的索引
    }
    ```

=== "TS"

    ```typescript title="quick_sort.ts"
    /* 选取三个候选元素的中位数 */
    medianThree(
        nums: number[],
        left: number,
        mid: number,
        right: number
    ): number {
        let l = nums[left],
            m = nums[mid],
            r = nums[right];
        // m 在 l 和 r 之间
        if ((l <= m && m <= r) || (r <= m && m <= l)) return mid;
        // l 在 m 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m)) return left;
        return right;
    }

    /* 哨兵划分（三数取中值） */
    partition(nums: number[], left: number, right: number): number {
        // 选取三个候选元素的中位数
        let med = this.medianThree(
            nums,
            left,
            Math.floor((left + right) / 2),
            right
        );
        // 将中位数交换至数组最左端
        this.swap(nums, left, med);
        // 以 nums[left] 为基准数
        let i = left,
            j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left]) {
                j--; // 从右向左找首个小于基准数的元素
            }
            while (i < j && nums[i] <= nums[left]) {
                i++; // 从左向右找首个大于基准数的元素
            }
            this.swap(nums, i, j); // 交换这两个元素
        }
        this.swap(nums, i, left); // 将基准数交换至两子数组的分界线
        return i; // 返回基准数的索引
    }
    ```

=== "Dart"

    ```dart title="quick_sort.dart"
    /* 选取三个候选元素的中位数 */
    int _medianThree(List<int> nums, int left, int mid, int right) {
      int l = nums[left], m = nums[mid], r = nums[right];
      if ((l <= m && m <= r) || (r <= m && m <= l))
        return mid; // m 在 l 和 r 之间
      if ((m <= l && l <= r) || (r <= l && l <= m))
        return left; // l 在 m 和 r 之间
      return right;
    }

    /* 哨兵划分（三数取中值） */
    int _partition(List<int> nums, int left, int right) {
      // 选取三个候选元素的中位数
      int med = _medianThree(nums, left, (left + right) ~/ 2, right);
      // 将中位数交换至数组最左端
      _swap(nums, left, med);
      // 以 nums[left] 为基准数
      int i = left, j = right;
      while (i < j) {
        while (i < j && nums[j] >= nums[left]) j--; // 从右向左找首个小于基准数的元素
        while (i < j && nums[i] <= nums[left]) i++; // 从左向右找首个大于基准数的元素
        _swap(nums, i, j); // 交换这两个元素
      }
      _swap(nums, i, left); // 将基准数交换至两子数组的分界线
      return i; // 返回基准数的索引
    }
    ```

=== "Rust"

    ```rust title="quick_sort.rs"
    /* 选取三个候选元素的中位数 */
    fn median_three(nums: &mut [i32], left: usize, mid: usize, right: usize) -> usize {
        let (l, m, r) = (nums[left], nums[mid], nums[right]);
        if (l <= m && m <= r) || (r <= m && m <= l) {
            return mid; // m 在 l 和 r 之间
        }
        if (m <= l && l <= r) || (r <= l && l <= m) {
            return left; // l 在 m 和 r 之间
        }
        right
    }

    /* 哨兵划分（三数取中值） */
    fn partition(nums: &mut [i32], left: usize, right: usize) -> usize {
        // 选取三个候选元素的中位数
        let med = Self::median_three(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        nums.swap(left, med);
        // 以 nums[left] 为基准数
        let (mut i, mut j) = (left, right);
        while i < j {
            while i < j && nums[j] >= nums[left] {
                j -= 1; // 从右向左找首个小于基准数的元素
            }
            while i < j && nums[i] <= nums[left] {
                i += 1; // 从左向右找首个大于基准数的元素
            }
            nums.swap(i, j); // 交换这两个元素
        }
        nums.swap(i, left); // 将基准数交换至两子数组的分界线
        i // 返回基准数的索引
    }
    ```

=== "C"

    ```c title="quick_sort.c"
    /* 选取三个候选元素的中位数 */
    int medianThree(int nums[], int left, int mid, int right) {
        int l = nums[left], m = nums[mid], r = nums[right];
        if ((l <= m && m <= r) || (r <= m && m <= l))
            return mid; // m 在 l 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m))
            return left; // l 在 m 和 r 之间
        return right;
    }

    /* 哨兵划分（三数取中值） */
    int partitionMedian(int nums[], int left, int right) {
        // 选取三个候选元素的中位数
        int med = medianThree(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        swap(nums, left, med);
        // 以 nums[left] 为基准数
        int i = left, j = right;
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--; // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++;          // 从左向右找首个大于基准数的元素
            swap(nums, i, j); // 交换这两个元素
        }
        swap(nums, i, left); // 将基准数交换至两子数组的分界线
        return i;            // 返回基准数的索引
    }
    ```

=== "Kotlin"

    ```kotlin title="quick_sort.kt"
    /* 选取三个候选元素的中位数 */
    fun medianThree(nums: IntArray, left: Int, mid: Int, right: Int): Int {
        val l = nums[left]
        val m = nums[mid]
        val r = nums[right]
        if ((m in l..r) || (m in r..l))
            return mid  // m 在 l 和 r 之间
        if ((l in m..r) || (l in r..m))
            return left // l 在 m 和 r 之间
        return right
    }

    /* 哨兵划分（三数取中值） */
    fun partitionMedian(nums: IntArray, left: Int, right: Int): Int {
        // 选取三个候选元素的中位数
        val med = medianThree(nums, left, (left + right) / 2, right)
        // 将中位数交换至数组最左端
        swap(nums, left, med)
        // 以 nums[left] 为基准数
        var i = left
        var j = right
        while (i < j) {
            while (i < j && nums[j] >= nums[left])
                j--                      // 从右向左找首个小于基准数的元素
            while (i < j && nums[i] <= nums[left])
                i++                      // 从左向右找首个大于基准数的元素
            swap(nums, i, j)             // 交换这两个元素
        }
        swap(nums, i, left)              // 将基准数交换至两子数组的分界线
        return i                         // 返回基准数的索引
    }
    ```

=== "Ruby"

    ```ruby title="quick_sort.rb"
    ### 选取三个候选元素的中位数 ###
    def median_three(nums, left, mid, right)
      # 选取三个候选元素的中位数
      _l, _m, _r = nums[left], nums[mid], nums[right]
      # m 在 l 和 r 之间
      return mid if (_l <= _m && _m <= _r) || (_r <= _m && _m <= _l)
      # l 在 m 和 r 之间
      return left if (_m <= _l && _l <= _r) || (_r <= _l && _l <= _m)
      return right
    end

    ### 哨兵划分（三数取中值）###
    def partition(nums, left, right)
      ### 以 nums[left] 为基准数
      med = median_three(nums, left, (left + right) / 2, right)
      # 将中位数交换至数组最左断
      nums[left], nums[med] = nums[med], nums[left]
      i, j = left, right
      while i < j
        while i < j && nums[j] >= nums[left]
          j -= 1 # 从右向左找首个小于基准数的元素
        end
        while i < j && nums[i] <= nums[left]
          i += 1 # 从左向右找首个大于基准数的元素
        end
        # 元素交换
        nums[i], nums[j] = nums[j], nums[i]
      end
      # 将基准数交换至两子数组的分界线
      nums[i], nums[left] = nums[left], nums[i]
      i # 返回基准数的索引
    end
    ```

=== "Zig"

    ```zig title="quick_sort.zig"
    // 选取三个候选元素的中位数
    fn medianThree(nums: []i32, left: usize, mid: usize, right: usize) usize {
        var l = nums[left];
        var m = nums[mid];
        var r = nums[right];
        if ((l <= m && m <= r) || (r <= m && m <= l))
            return mid; // m 在 l 和 r 之间
        if ((m <= l && l <= r) || (r <= l && l <= m))
            return left; // l 在 m 和 r 之间
        return right;
    }

    // 哨兵划分（三数取中值）
    fn partition(nums: []i32, left: usize, right: usize) usize {
        // 选取三个候选元素的中位数
        var med = medianThree(nums, left, (left + right) / 2, right);
        // 将中位数交换至数组最左端
        swap(nums, left, med);
        // 以 nums[left] 为基准数
        var i = left;
        var j = right;
        while (i < j) {
            while (i < j and nums[j] >= nums[left]) j -= 1; // 从右向左找首个小于基准数的元素
            while (i < j and nums[i] <= nums[left]) i += 1; // 从左向右找首个大于基准数的元素
            swap(nums, i, j);   // 交换这两个元素
        }
        swap(nums, i, left);    // 将基准数交换至两子数组的分界线
        return i;               // 返回基准数的索引
    }
    ```

??? pythontutor "可视化运行"

    <div style="height: 549px; width: 100%;"><iframe class="pythontutor-iframe" src="https://pythontutor.com/iframe-embed.html#code=def%20median_three%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20mid%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E9%80%89%E5%8F%96%E4%B8%89%E4%B8%AA%E5%80%99%E9%80%89%E5%85%83%E7%B4%A0%E7%9A%84%E4%B8%AD%E4%BD%8D%E6%95%B0%22%22%22%0A%20%20%20%20l,%20m,%20r%20%3D%20nums%5Bleft%5D,%20nums%5Bmid%5D,%20nums%5Bright%5D%0A%20%20%20%20if%20%28l%20%3C%3D%20m%20%3C%3D%20r%29%20or%20%28r%20%3C%3D%20m%20%3C%3D%20l%29%3A%0A%20%20%20%20%20%20%20%20return%20mid%20%20%23%20m%20%E5%9C%A8%20l%20%E5%92%8C%20r%20%E4%B9%8B%E9%97%B4%0A%20%20%20%20if%20%28m%20%3C%3D%20l%20%3C%3D%20r%29%20or%20%28r%20%3C%3D%20l%20%3C%3D%20m%29%3A%0A%20%20%20%20%20%20%20%20return%20left%20%20%23%20l%20%E5%9C%A8%20m%20%E5%92%8C%20r%20%E4%B9%8B%E9%97%B4%0A%20%20%20%20return%20right%0A%0Adef%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%EF%BC%88%E4%B8%89%E6%95%B0%E5%8F%96%E4%B8%AD%E5%80%BC%EF%BC%89%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20med%20%3D%20median_three%28nums,%20left,%20%28left%20%2B%20right%29%20//%202,%20right%29%0A%20%20%20%20%23%20%E5%B0%86%E4%B8%AD%E4%BD%8D%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E6%95%B0%E7%BB%84%E6%9C%80%E5%B7%A6%E7%AB%AF%0A%20%20%20%20nums%5Bleft%5D,%20nums%5Bmed%5D%20%3D%20nums%5Bmed%5D,%20nums%5Bleft%5D%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E4%B8%AD%E4%BD%8D%E5%9F%BA%E5%87%86%E6%95%B0%E4%BC%98%E5%8C%96%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20partition%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%EF%BC%88%E4%B8%AD%E4%BD%8D%E5%9F%BA%E5%87%86%E6%95%B0%E4%BC%98%E5%8C%96%EF%BC%89%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=472&codeDivWidth=350&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false"> </iframe></div>
    <div style="margin-top: 5px;"><a href="https://pythontutor.com/iframe-embed.html#code=def%20median_three%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20mid%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E9%80%89%E5%8F%96%E4%B8%89%E4%B8%AA%E5%80%99%E9%80%89%E5%85%83%E7%B4%A0%E7%9A%84%E4%B8%AD%E4%BD%8D%E6%95%B0%22%22%22%0A%20%20%20%20l,%20m,%20r%20%3D%20nums%5Bleft%5D,%20nums%5Bmid%5D,%20nums%5Bright%5D%0A%20%20%20%20if%20%28l%20%3C%3D%20m%20%3C%3D%20r%29%20or%20%28r%20%3C%3D%20m%20%3C%3D%20l%29%3A%0A%20%20%20%20%20%20%20%20return%20mid%20%20%23%20m%20%E5%9C%A8%20l%20%E5%92%8C%20r%20%E4%B9%8B%E9%97%B4%0A%20%20%20%20if%20%28m%20%3C%3D%20l%20%3C%3D%20r%29%20or%20%28r%20%3C%3D%20l%20%3C%3D%20m%29%3A%0A%20%20%20%20%20%20%20%20return%20left%20%20%23%20l%20%E5%9C%A8%20m%20%E5%92%8C%20r%20%E4%B9%8B%E9%97%B4%0A%20%20%20%20return%20right%0A%0Adef%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%EF%BC%88%E4%B8%89%E6%95%B0%E5%8F%96%E4%B8%AD%E5%80%BC%EF%BC%89%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20med%20%3D%20median_three%28nums,%20left,%20%28left%20%2B%20right%29%20//%202,%20right%29%0A%20%20%20%20%23%20%E5%B0%86%E4%B8%AD%E4%BD%8D%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E6%95%B0%E7%BB%84%E6%9C%80%E5%B7%A6%E7%AB%AF%0A%20%20%20%20nums%5Bleft%5D,%20nums%5Bmed%5D%20%3D%20nums%5Bmed%5D,%20nums%5Bleft%5D%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E4%B8%AD%E4%BD%8D%E5%9F%BA%E5%87%86%E6%95%B0%E4%BC%98%E5%8C%96%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20partition%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%EF%BC%88%E4%B8%AD%E4%BD%8D%E5%9F%BA%E5%87%86%E6%95%B0%E4%BC%98%E5%8C%96%EF%BC%89%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=800&codeDivWidth=600&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false" target="_blank" rel="noopener noreferrer">全屏观看 ></a></div>

## 11.5.5 &nbsp; 递归深度优化

**在某些输入下，快速排序可能占用空间较多**。以完全有序的输入数组为例，设递归中的子数组长度为 $m$ ，每轮哨兵划分操作都将产生长度为 $0$ 的左子数组和长度为 $m - 1$ 的右子数组，这意味着每一层递归调用减少的问题规模非常小（只减少一个元素），递归树的高度会达到 $n - 1$ ，此时需要占用 $O(n)$ 大小的栈帧空间。

为了防止栈帧空间的累积，我们可以在每轮哨兵排序完成后，比较两个子数组的长度，**仅对较短的子数组进行递归**。由于较短子数组的长度不会超过 $n / 2$ ，因此这种方法能确保递归深度不超过 $\log n$ ，从而将最差空间复杂度优化至 $O(\log n)$ 。代码如下所示：

=== "Python"

    ```python title="quick_sort.py"
    def quick_sort(self, nums: list[int], left: int, right: int):
        """快速排序（递归深度优化）"""
        # 子数组长度为 1 时终止
        while left < right:
            # 哨兵划分操作
            pivot = self.partition(nums, left, right)
            # 对两个子数组中较短的那个执行快速排序
            if pivot - left < right - pivot:
                self.quick_sort(nums, left, pivot - 1)  # 递归排序左子数组
                left = pivot + 1  # 剩余未排序区间为 [pivot + 1, right]
            else:
                self.quick_sort(nums, pivot + 1, right)  # 递归排序右子数组
                right = pivot - 1  # 剩余未排序区间为 [left, pivot - 1]
    ```

=== "C++"

    ```cpp title="quick_sort.cpp"
    /* 快速排序（递归深度优化） */
    void quickSort(vector<int> &nums, int left, int right) {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            int pivot = partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                quickSort(nums, left, pivot - 1); // 递归排序左子数组
                left = pivot + 1;                 // 剩余未排序区间为 [pivot + 1, right]
            } else {
                quickSort(nums, pivot + 1, right); // 递归排序右子数组
                right = pivot - 1;                 // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "Java"

    ```java title="quick_sort.java"
    /* 快速排序（递归深度优化） */
    void quickSort(int[] nums, int left, int right) {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            int pivot = partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                quickSort(nums, left, pivot - 1); // 递归排序左子数组
                left = pivot + 1; // 剩余未排序区间为 [pivot + 1, right]
            } else {
                quickSort(nums, pivot + 1, right); // 递归排序右子数组
                right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "C#"

    ```csharp title="quick_sort.cs"
    /* 快速排序（递归深度优化） */
    void QuickSort(int[] nums, int left, int right) {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            int pivot = Partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                QuickSort(nums, left, pivot - 1);  // 递归排序左子数组
                left = pivot + 1;  // 剩余未排序区间为 [pivot + 1, right]
            } else {
                QuickSort(nums, pivot + 1, right); // 递归排序右子数组
                right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "Go"

    ```go title="quick_sort.go"
    /* 快速排序（递归深度优化）*/
    func (q *quickSortTailCall) quickSort(nums []int, left, right int) {
        // 子数组长度为 1 时终止
        for left < right {
            // 哨兵划分操作
            pivot := q.partition(nums, left, right)
            // 对两个子数组中较短的那个执行快速排序
            if pivot-left < right-pivot {
                q.quickSort(nums, left, pivot-1) // 递归排序左子数组
                left = pivot + 1                 // 剩余未排序区间为 [pivot + 1, right]
            } else {
                q.quickSort(nums, pivot+1, right) // 递归排序右子数组
                right = pivot - 1                 // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "Swift"

    ```swift title="quick_sort.swift"
    /* 快速排序（递归深度优化） */
    func quickSortTailCall(nums: inout [Int], left: Int, right: Int) {
        var left = left
        var right = right
        // 子数组长度为 1 时终止
        while left < right {
            // 哨兵划分操作
            let pivot = partition(nums: &nums, left: left, right: right)
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left) < (right - pivot) {
                quickSortTailCall(nums: &nums, left: left, right: pivot - 1) // 递归排序左子数组
                left = pivot + 1 // 剩余未排序区间为 [pivot + 1, right]
            } else {
                quickSortTailCall(nums: &nums, left: pivot + 1, right: right) // 递归排序右子数组
                right = pivot - 1 // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "JS"

    ```javascript title="quick_sort.js"
    /* 快速排序（递归深度优化） */
    quickSort(nums, left, right) {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            let pivot = this.partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                this.quickSort(nums, left, pivot - 1); // 递归排序左子数组
                left = pivot + 1; // 剩余未排序区间为 [pivot + 1, right]
            } else {
                this.quickSort(nums, pivot + 1, right); // 递归排序右子数组
                right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "TS"

    ```typescript title="quick_sort.ts"
    /* 快速排序（递归深度优化） */
    quickSort(nums: number[], left: number, right: number): void {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            let pivot = this.partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                this.quickSort(nums, left, pivot - 1); // 递归排序左子数组
                left = pivot + 1; // 剩余未排序区间为 [pivot + 1, right]
            } else {
                this.quickSort(nums, pivot + 1, right); // 递归排序右子数组
                right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "Dart"

    ```dart title="quick_sort.dart"
    /* 快速排序（递归深度优化） */
    void quickSort(List<int> nums, int left, int right) {
      // 子数组长度为 1 时终止
      while (left < right) {
        // 哨兵划分操作
        int pivot = _partition(nums, left, right);
        // 对两个子数组中较短的那个执行快速排序
        if (pivot - left < right - pivot) {
          quickSort(nums, left, pivot - 1); // 递归排序左子数组
          left = pivot + 1; // 剩余未排序区间为 [pivot + 1, right]
        } else {
          quickSort(nums, pivot + 1, right); // 递归排序右子数组
          right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
        }
      }
    }
    ```

=== "Rust"

    ```rust title="quick_sort.rs"
    /* 快速排序（递归深度优化） */
    pub fn quick_sort(mut left: i32, mut right: i32, nums: &mut [i32]) {
        // 子数组长度为 1 时终止
        while left < right {
            // 哨兵划分操作
            let pivot = Self::partition(nums, left as usize, right as usize) as i32;
            // 对两个子数组中较短的那个执行快速排序
            if pivot - left < right - pivot {
                Self::quick_sort(left, pivot - 1, nums); // 递归排序左子数组
                left = pivot + 1; // 剩余未排序区间为 [pivot + 1, right]
            } else {
                Self::quick_sort(pivot + 1, right, nums); // 递归排序右子数组
                right = pivot - 1; // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "C"

    ```c title="quick_sort.c"
    /* 快速排序（递归深度优化） */
    void quickSortTailCall(int nums[], int left, int right) {
        // 子数组长度为 1 时终止
        while (left < right) {
            // 哨兵划分操作
            int pivot = partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                // 递归排序左子数组
                quickSortTailCall(nums, left, pivot - 1);
                // 剩余未排序区间为 [pivot + 1, right]
                left = pivot + 1;
            } else {
                // 递归排序右子数组
                quickSortTailCall(nums, pivot + 1, right);
                // 剩余未排序区间为 [left, pivot - 1]
                right = pivot - 1;
            }
        }
    }
    ```

=== "Kotlin"

    ```kotlin title="quick_sort.kt"
    /* 快速排序（递归深度优化） */
    fun quickSortTailCall(nums: IntArray, left: Int, right: Int) {
        // 子数组长度为 1 时终止
        var l = left
        var r = right
        while (l < r) {
            // 哨兵划分操作
            val pivot = partition(nums, l, r)
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - l < r - pivot) {
                quickSort(nums, l, pivot - 1) // 递归排序左子数组
                l = pivot + 1 // 剩余未排序区间为 [pivot + 1, right]
            } else {
                quickSort(nums, pivot + 1, r) // 递归排序右子数组
                r = pivot - 1 // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

=== "Ruby"

    ```ruby title="quick_sort.rb"
    ### 快速排序（递归深度优化）###
    def quick_sort(nums, left, right)
      # 子数组长度不为 1 时递归
      while left < right
        # 哨兵划分
        pivot = partition(nums, left, right)
        # 对两个子数组中较短的那个执行快速排序
        if pivot - left < right - pivot
          quick_sort(nums, left, pivot - 1)
          left = pivot + 1 # 剩余未排序区间为 [pivot + 1, right]
        else
          quick_sort(nums, pivot + 1, right)
          right = pivot - 1 # 剩余未排序区间为 [left, pivot - 1]
        end
      end
    end
    ```

=== "Zig"

    ```zig title="quick_sort.zig"
    // 快速排序（递归深度优化）
    fn quickSort(nums: []i32, left_: usize, right_: usize) void {
        var left = left_;
        var right = right_;
        // 子数组长度为 1 时终止递归
        while (left < right) {
            // 哨兵划分操作
            var pivot = partition(nums, left, right);
            // 对两个子数组中较短的那个执行快速排序
            if (pivot - left < right - pivot) {
                quickSort(nums, left, pivot - 1);   // 递归排序左子数组
                left = pivot + 1;                   // 剩余未排序区间为 [pivot + 1, right]
            } else {
                quickSort(nums, pivot + 1, right);  // 递归排序右子数组
                right = pivot - 1;                  // 剩余未排序区间为 [left, pivot - 1]
            }
        }
    }
    ```

??? pythontutor "可视化运行"

    <div style="height: 549px; width: 100%;"><iframe class="pythontutor-iframe" src="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0Adef%20quick_sort%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%3A%0A%20%20%20%20%22%22%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%22%22%22%0A%20%20%20%20%23%20%E5%AD%90%E6%95%B0%E7%BB%84%E9%95%BF%E5%BA%A6%E4%B8%BA%201%20%E6%97%B6%E7%BB%88%E6%AD%A2%0A%20%20%20%20while%20left%20%3C%20right%3A%0A%20%20%20%20%20%20%20%20%23%20%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%E6%93%8D%E4%BD%9C%0A%20%20%20%20%20%20%20%20pivot%20%3D%20partition%28nums,%20left,%20right%29%0A%20%20%20%20%20%20%20%20%23%20%E5%AF%B9%E4%B8%A4%E4%B8%AA%E5%AD%90%E6%95%B0%E7%BB%84%E4%B8%AD%E8%BE%83%E7%9F%AD%E7%9A%84%E9%82%A3%E4%B8%AA%E6%89%A7%E8%A1%8C%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%0A%20%20%20%20%20%20%20%20if%20pivot%20-%20left%20%3C%20right%20-%20pivot%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20quick_sort%28nums,%20left,%20pivot%20-%201%29%20%20%23%20%E9%80%92%E5%BD%92%E6%8E%92%E5%BA%8F%E5%B7%A6%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20%20%20%20%20%20%20%20%20left%20%3D%20pivot%20%2B%201%20%20%23%20%E5%89%A9%E4%BD%99%E6%9C%AA%E6%8E%92%E5%BA%8F%E5%8C%BA%E9%97%B4%E4%B8%BA%20%5Bpivot%20%2B%201,%20right%5D%0A%20%20%20%20%20%20%20%20else%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20quick_sort%28nums,%20pivot%20%2B%201,%20right%29%20%20%23%20%E9%80%92%E5%BD%92%E6%8E%92%E5%BA%8F%E5%8F%B3%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20%20%20%20%20%20%20%20%20right%20%3D%20pivot%20-%201%20%20%23%20%E5%89%A9%E4%BD%99%E6%9C%AA%E6%8E%92%E5%BA%8F%E5%8C%BA%E9%97%B4%E4%B8%BA%20%5Bleft,%20pivot%20-%201%5D%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20quick_sort%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=472&codeDivWidth=350&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false"> </iframe></div>
    <div style="margin-top: 5px;"><a href="https://pythontutor.com/iframe-embed.html#code=def%20partition%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%20-%3E%20int%3A%0A%20%20%20%20%22%22%22%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%22%22%22%0A%20%20%20%20%23%20%E4%BB%A5%20nums%5Bleft%5D%20%E4%B8%BA%E5%9F%BA%E5%87%86%E6%95%B0%0A%20%20%20%20i,%20j%20%3D%20left,%20right%0A%20%20%20%20while%20i%20%3C%20j%3A%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bj%5D%20%3E%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20j%20-%3D%201%20%20%23%20%E4%BB%8E%E5%8F%B3%E5%90%91%E5%B7%A6%E6%89%BE%E9%A6%96%E4%B8%AA%E5%B0%8F%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20while%20i%20%3C%20j%20and%20nums%5Bi%5D%20%3C%3D%20nums%5Bleft%5D%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20i%20%2B%3D%201%20%20%23%20%E4%BB%8E%E5%B7%A6%E5%90%91%E5%8F%B3%E6%89%BE%E9%A6%96%E4%B8%AA%E5%A4%A7%E4%BA%8E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E5%85%83%E7%B4%A0%0A%20%20%20%20%20%20%20%20%23%20%E5%85%83%E7%B4%A0%E4%BA%A4%E6%8D%A2%0A%20%20%20%20%20%20%20%20nums%5Bi%5D,%20nums%5Bj%5D%20%3D%20nums%5Bj%5D,%20nums%5Bi%5D%0A%20%20%20%20%23%20%E5%B0%86%E5%9F%BA%E5%87%86%E6%95%B0%E4%BA%A4%E6%8D%A2%E8%87%B3%E4%B8%A4%E5%AD%90%E6%95%B0%E7%BB%84%E7%9A%84%E5%88%86%E7%95%8C%E7%BA%BF%0A%20%20%20%20nums%5Bi%5D,%20nums%5Bleft%5D%20%3D%20nums%5Bleft%5D,%20nums%5Bi%5D%0A%20%20%20%20return%20i%20%20%23%20%E8%BF%94%E5%9B%9E%E5%9F%BA%E5%87%86%E6%95%B0%E7%9A%84%E7%B4%A2%E5%BC%95%0A%0Adef%20quick_sort%28nums%3A%20list%5Bint%5D,%20left%3A%20int,%20right%3A%20int%29%3A%0A%20%20%20%20%22%22%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%22%22%22%0A%20%20%20%20%23%20%E5%AD%90%E6%95%B0%E7%BB%84%E9%95%BF%E5%BA%A6%E4%B8%BA%201%20%E6%97%B6%E7%BB%88%E6%AD%A2%0A%20%20%20%20while%20left%20%3C%20right%3A%0A%20%20%20%20%20%20%20%20%23%20%E5%93%A8%E5%85%B5%E5%88%92%E5%88%86%E6%93%8D%E4%BD%9C%0A%20%20%20%20%20%20%20%20pivot%20%3D%20partition%28nums,%20left,%20right%29%0A%20%20%20%20%20%20%20%20%23%20%E5%AF%B9%E4%B8%A4%E4%B8%AA%E5%AD%90%E6%95%B0%E7%BB%84%E4%B8%AD%E8%BE%83%E7%9F%AD%E7%9A%84%E9%82%A3%E4%B8%AA%E6%89%A7%E8%A1%8C%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%0A%20%20%20%20%20%20%20%20if%20pivot%20-%20left%20%3C%20right%20-%20pivot%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20quick_sort%28nums,%20left,%20pivot%20-%201%29%20%20%23%20%E9%80%92%E5%BD%92%E6%8E%92%E5%BA%8F%E5%B7%A6%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20%20%20%20%20%20%20%20%20left%20%3D%20pivot%20%2B%201%20%20%23%20%E5%89%A9%E4%BD%99%E6%9C%AA%E6%8E%92%E5%BA%8F%E5%8C%BA%E9%97%B4%E4%B8%BA%20%5Bpivot%20%2B%201,%20right%5D%0A%20%20%20%20%20%20%20%20else%3A%0A%20%20%20%20%20%20%20%20%20%20%20%20quick_sort%28nums,%20pivot%20%2B%201,%20right%29%20%20%23%20%E9%80%92%E5%BD%92%E6%8E%92%E5%BA%8F%E5%8F%B3%E5%AD%90%E6%95%B0%E7%BB%84%0A%20%20%20%20%20%20%20%20%20%20%20%20right%20%3D%20pivot%20-%201%20%20%23%20%E5%89%A9%E4%BD%99%E6%9C%AA%E6%8E%92%E5%BA%8F%E5%8C%BA%E9%97%B4%E4%B8%BA%20%5Bleft,%20pivot%20-%201%5D%0A%0A%22%22%22Driver%20Code%22%22%22%0Aif%20__name__%20%3D%3D%20%22__main__%22%3A%0A%20%20%20%20%23%20%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%0A%20%20%20%20nums%20%3D%20%5B2,%204,%201,%200,%203,%205%5D%0A%20%20%20%20quick_sort%28nums,%200,%20len%28nums%29%20-%201%29%0A%20%20%20%20print%28%22%E5%BF%AB%E9%80%9F%E6%8E%92%E5%BA%8F%EF%BC%88%E5%B0%BE%E9%80%92%E5%BD%92%E4%BC%98%E5%8C%96%EF%BC%89%E5%AE%8C%E6%88%90%E5%90%8E%20nums%20%3D%22,%20nums%29&codeDivHeight=800&codeDivWidth=600&cumulative=false&curInstr=5&heapPrimitives=nevernest&origin=opt-frontend.js&py=311&rawInputLstJSON=%5B%5D&textReferences=false" target="_blank" rel="noopener noreferrer">全屏观看 ></a></div>
