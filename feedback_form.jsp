<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDate" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Training Feedback Form</title>
<style>
    body { 
        font-family: Arial, sans-serif; 
        padding: 20px; 
        background-color: #f7f7f7;
    }
    h2 { color: #333; }
    table { 
        border-collapse: collapse; 
        width: 100%; 
        margin-bottom: 20px; 
        background-color: #fff; 
        border-radius: 8px; 
        padding: 10px;
    }
    th, td { 
        padding: 8px; 
        border: 1px solid #ddd; 
        vertical-align: top; 
    }
    th { background-color: #f0f0f0; text-align: left; }
    input[type="text"], textarea {
        width: 95%;
        padding: 6px;
        border-radius: 4px;
        border: 1px solid #ccc;
        font-size: 14px;
        box-sizing: border-box;
    }
    textarea { resize: vertical; }
    .rating input { margin-right: 4px; vertical-align: middle; }
    .rating label { margin-right: 12px; }
    button {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s ease, transform 0.2s ease;
        margin-right: 10px;
    }
    button:hover { background-color: #45a049; transform: scale(1.05); }
    button:active { transform: scale(0.98); }
</style>
</head>
<body>
<h2>प्रशिक्षण फीडबैक फ़ॉर्म</h2>
<p>कृपया अपने नाम और कार्यालय का उल्लेख करें तथा प्रत्येक प्रश्न के लिए एक विकल्प चुनें।</p>

<form action="SubmitFeedbackServlet" method="post" accept-charset="UTF-8">

<table>
    <tr>
        <th>प्रशिक्षु का नाम</th>
        <td><input type="text" name="trainee_name" required maxlength="30" placeholder="पूरा नाम लिखें"></td>
    </tr>
    <tr>
        <th>कार्यालय का नाम</th>
        <td><input type="text" name="office" required maxlength="30" placeholder="कार्यालय का नाम लिखें"></td>
    </tr>
</table>

<table>
    <tr>
        <th>क्रमांक</th>
        <th>कर्मचारी का नाम / पद</th>
        <th>बहुत अच्छा</th>
        <th>अच्छा</th>
        <th>सामान्य</th>
        <th>खराब</th>
        <th>बहुत खराब</th>
    </tr>

    <%-- Questions 1 to 20 --%>
    <%
        String[] names = {
            "Mr. Kshitij Jain (SYSTEM ANALYST)",
            "Mr. Sanjay Kumar Devaliya (MANAGER)",
            "Mr. Shri Kuldeep Bahadur Thapa (DEPUTY. MANAGER)",
            "Mrs. Khushboo Gupta (DEPUTY MANAGER)",
            "Shri Mohan Kumar Singh (EXECUTIVE ENGINEER)",
            "Shri. Bhal Chandra Tiwari (DEPUTY MANAGER)",
            "Mr. Ankit Sharma (JUNIOR ENGINEER)",
            "Mr. Avneesh Gupta (PROGRAMMER)",
            "Mr. Dinendra Ahirwar (PROGRAMMER)",
            "Shri Akshay Tiwari / Shri Dilip Uike (PARI SAHA)",
            "Mr. Mayank Singh (PROGRAMMER)",
            "Mr. Ghaneshwar Zarbade (PROGRAMMER)",
            "Shri Anant Panke (OFFICE ASSISTANT)",
            "Shri. Anuj Tiwari (OFFICE ASSISTANT)",
            "Mr. Abhay Patel (ASSISTANT ENGINEER)",
            "Shri. Parkash Singh (JUNIOR ENGINEER)",
            "Shri Akhilesh Bharti (JUNIOR ENGINEER)",
            "Shri Hari Singh Maravi (TEST SUPERVISOR)",
            "Shri. Prashant Chaubey (ASSISTANT ENGINEER)",
            "Shri. Ramu Chaudhary (DEPUTY GENERAL MANAGER)"
        };
        for(int i=0; i<names.length; i++){
    %>
    <tr>
        <td><%= (i+1) %></td>
        <td><%= names[i] %></td>
        <td class="rating"><input type="radio" name="q<%= (i+1) %>" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="q<%= (i+1) %>" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="q<%= (i+1) %>" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="q<%= (i+1) %>" value="खराब"></td>
        <td class="rating"><input type="radio" name="q<%= (i+1) %>" value="बहुत खराब"></td>
    </tr>
    <% } %>
</table>

<table>
    <tr>
        <th>कैंटीन / भोजन सुविधा</th>
        <th>बहुत अच्छा</th>
        <th>अच्छा</th>
        <th>सामान्य</th>
        <th>खराब</th>
        <th>बहुत खराब</th>
    </tr>
    <tr>
        <td>शयामा टेंडर्स (कैंटीन) का अनुभव</td>
        <td class="rating"><input type="radio" name="canteen_rating" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="canteen_rating" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="canteen_rating" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="canteen_rating" value="खराब"></td>
        <td class="rating"><input type="radio" name="canteen_rating" value="बहुत खराब"></td>
    </tr>
</table>

<table>
    <tr>
        <th>छात्रावास / सुविधा</th>
        <th>बहुत अच्छा</th>
        <th>अच्छा</th>
        <th>सामान्य</th>
        <th>खराब</th>
        <th>बहुत खराब</th>
    </tr>
    <tr>
        <td>सफाई</td>
        <td class="rating"><input type="radio" name="hostel_cleanliness" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="hostel_cleanliness" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="hostel_cleanliness" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="hostel_cleanliness" value="खराब"></td>
        <td class="rating"><input type="radio" name="hostel_cleanliness" value="बहुत खराब"></td>
    </tr>
    <tr>
        <td>पानी की सुविधा</td>
        <td class="rating"><input type="radio" name="hostel_water" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="hostel_water" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="hostel_water" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="hostel_water" value="खराब"></td>
        <td class="rating"><input type="radio" name="hostel_water" value="बहुत खराब"></td>
    </tr>
    <tr>
        <td>बिजली</td>
        <td class="rating"><input type="radio" name="hostel_electricity" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="hostel_electricity" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="hostel_electricity" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="hostel_electricity" value="खराब"></td>
        <td class="rating"><input type="radio" name="hostel_electricity" value="बहुत खराब"></td>
    </tr>
    <tr>
        <td>खाद्य गुणवत्ता</td>
        <td class="rating"><input type="radio" name="food_quality" value="बहुत अच्छा" required></td>
        <td class="rating"><input type="radio" name="food_quality" value="अच्छा"></td>
        <td class="rating"><input type="radio" name="food_quality" value="सामान्य"></td>
        <td class="rating"><input type="radio" name="food_quality" value="खराब"></td>
        <td class="rating"><input type="radio" name="food_quality" value="बहुत खराब"></td>
    </tr>
</table>

<table>
    <tr>
        <th>टिप्पणियाँ (यदि कोई हो)</th>
    </tr>
    <tr>
        <td><textarea name="remarks" rows="4"></textarea></td>
    </tr>
</table>

<div style="margin-top:12px;">
    <button type="submit">सर्वे सबमिट करें</button>
    <button type="reset">रीसेट</button>
</div>

</form>
</body>
</html>
