import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.json.JSONArray;
import org.json.JSONObject;
import java.io.StringWriter;

@WebServlet("/MenuServlet")
public class MenuServlet extends HttpServlet {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/boba"; // Replace!
    private static final String DB_USER = "root"; // Replace!
    private static final String DB_PASSWORD = "1234"; // Replace!

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        JSONArray menuArray = new JSONArray();

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT m.item_id, m.name, m.category, m.image, s.size, s.price " +
                         "FROM menu_items m " +
                         "JOIN item_sizes s ON m.item_id = s.item_id " +
                         "ORDER BY m.item_id, FIELD(s.size, 'Small', 'Medium', 'Large')";
           
            try (PreparedStatement stmt = conn.prepareStatement(sql);
                 ResultSet rs = stmt.executeQuery()) {

                JSONObject currentItem = null;
                int lastItemId = -1;
                JSONArray sizesArray = null;

                while (rs.next()) {
                    int itemId = rs.getInt("item_id");
                    


                    if (itemId != lastItemId) {
                        if (currentItem != null) {
                            currentItem.put("sizes", sizesArray);
                            menuArray.put(currentItem);
                        }

                        currentItem = new JSONObject();
                        currentItem.put("item_id", itemId);
                        currentItem.put("name", rs.getString("name"));
                        currentItem.put("category", rs.getString("category"));
                        currentItem.put("image", rs.getString("image"));
                        sizesArray = new JSONArray();
                        lastItemId = itemId;
                    }

                    JSONObject sizeObj = new JSONObject();
                    sizeObj.put("size", rs.getString("size"));
                    sizeObj.put("price", rs.getBigDecimal("price"));
                    sizesArray.put(sizeObj);
                }

                if (currentItem != null) {
                    currentItem.put("sizes", sizesArray);
                    menuArray.put(currentItem);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(new JSONObject().put("error", "Database error").toString());
            return;
        }

        // Output the JSON
        try (PrintWriter out = response.getWriter()) {
            out.print(menuArray.toString());
        }
    }
}