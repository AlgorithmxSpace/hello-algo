---
comments: true
---

# 10.2 &nbsp; Binary search insertion

Binary search is not only used to search for target elements but also to solve many variant problems, such as searching for the insertion position of target elements.

## 10.2.1 &nbsp; Case with no duplicate elements

!!! question

    Given a sorted array `nums` of length $n$ with unique elements and an element `target`, insert `target` into `nums` while maintaining its sorted order. If `target` already exists in the array, insert it to the left of the existing element. Return the index of `target` in the array after insertion. See the example shown in Figure 10-4.

![Example data for binary search insertion point](binary_search_insertion.assets/binary_search_insertion_example.png){ class="animation-figure" }

<p align="center"> Figure 10-4 &nbsp; Example data for binary search insertion point </p>

If you want to reuse the binary search code from the previous section, you need to answer the following two questions.

**Question one**: If the array already contains `target`, would the insertion point be the index of existing element?

The requirement to insert `target` to the left of equal elements means that the newly inserted `target` will replace the original `target` position. In other words, **when the array contains `target`, the insertion point is indeed the index of that `target`**.

**Question two**: When the array does not contain `target`, at which index would it be inserted?

Let's further consider the binary search process: when `nums[m] < target`, pointer $i$ moves, meaning that pointer $i$ is approaching an element greater than or equal to `target`. Similarly, pointer $j$ is always approaching an element less than or equal to `target`.

Therefore, at the end of the binary, it is certain that: $i$ points to the first element greater than `target`, and $j$ points to the first element less than `target`. **It is easy to see that when the array does not contain `target`, the insertion point is $i$**. The code is as follows:

=== "Python"

    ```python title="binary_search_insertion.py"
    def binary_search_insertion_simple(nums: list[int], target: int) -> int:
        """Binary search for insertion point (no duplicate elements)"""
        i, j = 0, len(nums) - 1  # Initialize double closed interval [0, n-1]
        while i <= j:
            m = i + (j - i) // 2  # Calculate midpoint index m
            if nums[m] < target:
                i = m + 1  # Target is in interval [m+1, j]
            elif nums[m] > target:
                j = m - 1  # Target is in interval [i, m-1]
            else:
                return m  # Found target, return insertion point m
        # Did not find target, return insertion point i
        return i
    ```

=== "C++"

    ```cpp title="binary_search_insertion.cpp"
    /* Binary search for insertion point (no duplicate elements) */
    int binarySearchInsertionSimple(vector<int> &nums, int target) {
        int i = 0, j = nums.size() - 1; // Initialize double closed interval [0, n-1]
        while (i <= j) {
            int m = i + (j - i) / 2; // Calculate midpoint index m
            if (nums[m] < target) {
                i = m + 1; // Target is in interval [m+1, j]
            } else if (nums[m] > target) {
                j = m - 1; // Target is in interval [i, m-1]
            } else {
                return m; // Found target, return insertion point m
            }
        }
        // Did not find target, return insertion point i
        return i;
    }
    ```

=== "Java"

    ```java title="binary_search_insertion.java"
    /* Binary search for insertion point (no duplicate elements) */
    int binarySearchInsertionSimple(int[] nums, int target) {
        int i = 0, j = nums.length - 1; // Initialize double closed interval [0, n-1]
        while (i <= j) {
            int m = i + (j - i) / 2; // Calculate midpoint index m
            if (nums[m] < target) {
                i = m + 1; // Target is in interval [m+1, j]
            } else if (nums[m] > target) {
                j = m - 1; // Target is in interval [i, m-1]
            } else {
                return m; // Found target, return insertion point m
            }
        }
        // Did not find target, return insertion point i
        return i;
    }
    ```

=== "C#"

    ```csharp title="binary_search_insertion.cs"
    [class]{binary_search_insertion}-[func]{BinarySearchInsertionSimple}
    ```

=== "Go"

    ```go title="binary_search_insertion.go"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "Swift"

    ```swift title="binary_search_insertion.swift"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "JS"

    ```javascript title="binary_search_insertion.js"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "TS"

    ```typescript title="binary_search_insertion.ts"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "Dart"

    ```dart title="binary_search_insertion.dart"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "Rust"

    ```rust title="binary_search_insertion.rs"
    [class]{}-[func]{binary_search_insertion_simple}
    ```

=== "C"

    ```c title="binary_search_insertion.c"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "Kotlin"

    ```kotlin title="binary_search_insertion.kt"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

=== "Ruby"

    ```ruby title="binary_search_insertion.rb"
    [class]{}-[func]{binary_search_insertion_simple}
    ```

=== "Zig"

    ```zig title="binary_search_insertion.zig"
    [class]{}-[func]{binarySearchInsertionSimple}
    ```

## 10.2.2 &nbsp; Case with duplicate elements

!!! question

    Based on the previous question, assume the array may contain duplicate elements, all else remains the same.

When there are multiple occurrences of `target` in the array, a regular binary search can only return the index of one occurrence of `target`, **and it cannot determine how many occurrences of `target` are to the left and right of that position**.

The problem requires inserting the target element at the leftmost position, **so we need to find the index of the leftmost `target` in the array**. Initially consider implementing this through the steps shown in Figure 10-5.

1. Perform a binary search to find any index of `target`, say $k$.
2. Starting from index $k$, conduct a linear search to the left until the leftmost occurrence of `target` is found, then return this index.

![Linear search for the insertion point of duplicate elements](binary_search_insertion.assets/binary_search_insertion_naive.png){ class="animation-figure" }

<p align="center"> Figure 10-5 &nbsp; Linear search for the insertion point of duplicate elements </p>

Although this method is feasible, it includes linear search, so its time complexity is $O(n)$. This method is inefficient when the array contains many duplicate `target`s.

Now consider extending the binary search code. As shown in Figure 10-6, the overall process remains the same. In each round, we first calculate the middle index $m$, then compare the value of `target` with `nums[m]`, leading to the following cases.

- When `nums[m] < target` or `nums[m] > target`, it means `target` has not been found yet, thus use the normal binary search to narrow the search range, **bringing pointers $i$ and $j$ closer to `target`**.
- When `nums[m] == target`, it indicates that the elements less than `target` are in the range $[i, m - 1]$, therefore use $j = m - 1$ to narrow the range, **thus bringing pointer $j$ closer to the elements less than `target`**.

After the loop, $i$ points to the leftmost `target`, and $j$ points to the first element less than `target`, **therefore index $i$ is the insertion point**.

=== "<1>"
    ![Steps for binary search insertion point of duplicate elements](binary_search_insertion.assets/binary_search_insertion_step1.png){ class="animation-figure" }

=== "<2>"
    ![binary_search_insertion_step2](binary_search_insertion.assets/binary_search_insertion_step2.png){ class="animation-figure" }

=== "<3>"
    ![binary_search_insertion_step3](binary_search_insertion.assets/binary_search_insertion_step3.png){ class="animation-figure" }

=== "<4>"
    ![binary_search_insertion_step4](binary_search_insertion.assets/binary_search_insertion_step4.png){ class="animation-figure" }

=== "<5>"
    ![binary_search_insertion_step5](binary_search_insertion.assets/binary_search_insertion_step5.png){ class="animation-figure" }

=== "<6>"
    ![binary_search_insertion_step6](binary_search_insertion.assets/binary_search_insertion_step6.png){ class="animation-figure" }

=== "<7>"
    ![binary_search_insertion_step7](binary_search_insertion.assets/binary_search_insertion_step7.png){ class="animation-figure" }

=== "<8>"
    ![binary_search_insertion_step8](binary_search_insertion.assets/binary_search_insertion_step8.png){ class="animation-figure" }

<p align="center"> Figure 10-6 &nbsp; Steps for binary search insertion point of duplicate elements </p>

Observe the following code. The operations in the branches `nums[m] > target` and `nums[m] == target` are the same, so these two branches can be merged.

Even so, we can still keep the conditions expanded, as it makes the logic clearer and improves readability.

=== "Python"

    ```python title="binary_search_insertion.py"
    def binary_search_insertion(nums: list[int], target: int) -> int:
        """Binary search for insertion point (with duplicate elements)"""
        i, j = 0, len(nums) - 1  # Initialize double closed interval [0, n-1]
        while i <= j:
            m = i + (j - i) // 2  # Calculate midpoint index m
            if nums[m] < target:
                i = m + 1  # Target is in interval [m+1, j]
            elif nums[m] > target:
                j = m - 1  # Target is in interval [i, m-1]
            else:
                j = m - 1  # First element less than target is in interval [i, m-1]
        # Return insertion point i
        return i
    ```

=== "C++"

    ```cpp title="binary_search_insertion.cpp"
    /* Binary search for insertion point (with duplicate elements) */
    int binarySearchInsertion(vector<int> &nums, int target) {
        int i = 0, j = nums.size() - 1; // Initialize double closed interval [0, n-1]
        while (i <= j) {
            int m = i + (j - i) / 2; // Calculate midpoint index m
            if (nums[m] < target) {
                i = m + 1; // Target is in interval [m+1, j]
            } else if (nums[m] > target) {
                j = m - 1; // Target is in interval [i, m-1]
            } else {
                j = m - 1; // First element less than target is in interval [i, m-1]
            }
        }
        // Return insertion point i
        return i;
    }
    ```

=== "Java"

    ```java title="binary_search_insertion.java"
    /* Binary search for insertion point (with duplicate elements) */
    int binarySearchInsertion(int[] nums, int target) {
        int i = 0, j = nums.length - 1; // Initialize double closed interval [0, n-1]
        while (i <= j) {
            int m = i + (j - i) / 2; // Calculate midpoint index m
            if (nums[m] < target) {
                i = m + 1; // Target is in interval [m+1, j]
            } else if (nums[m] > target) {
                j = m - 1; // Target is in interval [i, m-1]
            } else {
                j = m - 1; // First element less than target is in interval [i, m-1]
            }
        }
        // Return insertion point i
        return i;
    }
    ```

=== "C#"

    ```csharp title="binary_search_insertion.cs"
    [class]{binary_search_insertion}-[func]{BinarySearchInsertion}
    ```

=== "Go"

    ```go title="binary_search_insertion.go"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "Swift"

    ```swift title="binary_search_insertion.swift"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "JS"

    ```javascript title="binary_search_insertion.js"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "TS"

    ```typescript title="binary_search_insertion.ts"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "Dart"

    ```dart title="binary_search_insertion.dart"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "Rust"

    ```rust title="binary_search_insertion.rs"
    [class]{}-[func]{binary_search_insertion}
    ```

=== "C"

    ```c title="binary_search_insertion.c"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "Kotlin"

    ```kotlin title="binary_search_insertion.kt"
    [class]{}-[func]{binarySearchInsertion}
    ```

=== "Ruby"

    ```ruby title="binary_search_insertion.rb"
    [class]{}-[func]{binary_search_insertion}
    ```

=== "Zig"

    ```zig title="binary_search_insertion.zig"
    [class]{}-[func]{binarySearchInsertion}
    ```

!!! tip

    The code in this section uses "closed interval". If you are interested in "left-closed, right-open", try to implement the code on your own.

In summary, binary search essentially involves setting search targets for pointers $i$ and $j$. These targets could be a specific element (like `target`) or a range of elements (such as those smaller than `target`).

In the continuous loop of binary search, pointers $i$ and $j$ gradually approach the predefined target. Ultimately, they either find the answer or stop after crossing the boundary.
