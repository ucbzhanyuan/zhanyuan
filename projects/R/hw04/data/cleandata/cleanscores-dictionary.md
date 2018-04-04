cleanscores-dictionary
================
Zhanyuan Zhang
November 22, 2017

cleanscores-dictinary
=====================

Zhanyuan Zhang November 22, 2017

#### This is a data set contains the cleaned scores for a fictionous Stat 133 class with 334 rows and 23 columns

<table>
<colgroup>
<col width="28%" />
<col width="71%" />
</colgroup>
<thead>
<tr class="header">
<th align="right"><strong>Type of assignments / columns</strong></th>
<th align="left"><strong>Description</strong></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td align="right">homework assignments</td>
<td align="left">columns <strong>HW1</strong> to <strong>HW9</strong>, each 100 pts</td>
</tr>
<tr class="even">
<td align="right">lab attendance</td>
<td align="left"><strong>ATT</strong>, number of attended labs (0 to 12)</td>
</tr>
<tr class="odd">
<td align="right">quiz scores</td>
<td align="left"><strong>QZ1</strong>, 12 pts <strong>QZ2</strong>, 18 pts <strong>QZ3</strong>, 20 pts <strong>QZ4</strong>, 20 pts</td>
</tr>
<tr class="even">
<td align="right">exam 1</td>
<td align="left"><strong>EX1</strong>, 80 pts</td>
</tr>
<tr class="odd">
<td align="right">exam 2</td>
<td align="left"><strong>EX2</strong>, 90 pts</td>
</tr>
<tr class="even">
<td align="right">Test 1</td>
<td align="left">columns <strong>Test1</strong>, rescaled <strong>EX1</strong> from 0 to 100</td>
</tr>
<tr class="odd">
<td align="right">Test 2</td>
<td align="left">columns <strong>Test2</strong>, rescaled <strong>EX2</strong> from 0 to 100</td>
</tr>
<tr class="even">
<td align="right">Homework</td>
<td align="left"><strong>Homework</strong>, Average of all the homework assignment score after dropping the lowest one</td>
</tr>
<tr class="odd">
<td align="right">Quiz</td>
<td align="left"><strong>Quiz</strong>, Average of all the quiz score after dropping the lowest one</td>
</tr>
<tr class="even">
<td align="right">Lab</td>
<td align="left"><strong>Lab</strong>, Lab scores after converting</td>
</tr>
<tr class="odd">
<td align="right">Overall</td>
<td align="left"><strong>Overall</strong>, 10% Lab score, 30% Homework score (drop the lowest HW), 15% Quiz score (drop the lowest quiz), 20% Test 1 score, 25% Test 2 score, Overall score is in scale 0 to 100</td>
</tr>
<tr class="even">
<td align="right">Grade</td>
<td align="left"><strong>Grade</strong>, assigned according to the overall scores. A+:[95, 100], A: [90, 95), A-: [88, 90), B+: [86, 88), B: [82, 86), B-: [79.5, 82), C+: [77.5, 79.5), C: [70, 77.5), C-: [60, 70), D: [50, 60), F: [0, 50)</td>
</tr>
</tbody>
</table>
