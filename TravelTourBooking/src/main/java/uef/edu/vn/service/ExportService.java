package uef.edu.vn.service;

import com.lowagie.text.*;
import com.lowagie.text.Font;
import com.lowagie.text.pdf.*;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import uef.edu.vn.dao.BookingDAO;
import uef.edu.vn.dao.PaymentDAO;
import uef.edu.vn.model.Booking;
import uef.edu.vn.model.Payment;

import jakarta.servlet.http.HttpServletResponse;
import java.awt.Color;
import java.io.IOException;
import java.io.OutputStream;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Locale;

/**
 * Service xử lý xuất file Excel và PDF.
 * - Excel: Danh sách Booking, Báo cáo doanh thu
 * - PDF: Hóa đơn chi tiết từng Booking
 */
public class ExportService {

    private final BookingDAO bookingDAO = new BookingDAO();
    private final PaymentDAO paymentDAO = new PaymentDAO();

    private static final NumberFormat VND_FORMAT =
            NumberFormat.getNumberInstance(new Locale("vi", "VN"));

    // =========================================================================
    // EXCEL: Danh sách Booking
    // =========================================================================

    public void exportBookingsToExcel(HttpServletResponse response) throws IOException {
        List<Booking> bookings = bookingDAO.getAllBookings();

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=danh_sach_booking.xlsx");

        try (Workbook workbook = new XSSFWorkbook();
             OutputStream out = response.getOutputStream()) {

            Sheet sheet = workbook.createSheet("Danh Sach Booking");
            sheet.setColumnWidth(0, 1500);
            sheet.setColumnWidth(1, 6000);
            sheet.setColumnWidth(2, 7000);
            sheet.setColumnWidth(3, 4000);
            sheet.setColumnWidth(4, 3000);
            sheet.setColumnWidth(5, 5000);
            sheet.setColumnWidth(6, 4000);

            // Style header
            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            org.apache.poi.ss.usermodel.Font headerFont = workbook.createFont();
            headerFont.setColor(IndexedColors.WHITE.getIndex());
            headerFont.setBold(true);
            headerFont.setFontHeightInPoints((short) 11);
            headerStyle.setFont(headerFont);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);
            headerStyle.setVerticalAlignment(VerticalAlignment.CENTER);
            headerStyle.setBorderBottom(BorderStyle.THIN);

            // Style noi dung (chan/le)
            CellStyle evenStyle = workbook.createCellStyle();
            evenStyle.setFillForegroundColor(IndexedColors.LIGHT_CORNFLOWER_BLUE.getIndex());
            evenStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            evenStyle.setBorderBottom(BorderStyle.THIN);
            evenStyle.setBorderRight(BorderStyle.THIN);

            CellStyle oddStyle = workbook.createCellStyle();
            oddStyle.setFillForegroundColor(IndexedColors.WHITE.getIndex());
            oddStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            oddStyle.setBorderBottom(BorderStyle.THIN);
            oddStyle.setBorderRight(BorderStyle.THIN);

            // Title row
            Row titleRow = sheet.createRow(0);
            titleRow.setHeight((short) 800);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("DANH SACH BOOKING - HE THONG DAT TOUR VOYAGER ELITE");
            CellStyle titleStyle = workbook.createCellStyle();
            org.apache.poi.ss.usermodel.Font titleFont = workbook.createFont();
            titleFont.setBold(true);
            titleFont.setFontHeightInPoints((short) 14);
            titleFont.setColor(IndexedColors.DARK_BLUE.getIndex());
            titleStyle.setFont(titleFont);
            titleCell.setCellStyle(titleStyle);
            sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(0, 0, 0, 6));

            // Header row
            String[] headers = {"#", "Khach Hang", "Ten Tour", "Ngay Dat", "So Nguoi", "Tong Tien", "Trang Thai"};
            Row headerRow = sheet.createRow(1);
            headerRow.setHeight((short) 600);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            // Data rows
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            int rowIdx = 2;
            for (Booking b : bookings) {
                Row row = sheet.createRow(rowIdx);
                CellStyle rowStyle = (rowIdx % 2 == 0) ? evenStyle : oddStyle;

                Cell c0 = row.createCell(0); c0.setCellValue(b.getBookingId()); c0.setCellStyle(rowStyle);
                Cell c1 = row.createCell(1); c1.setCellValue(b.getFullName() != null ? b.getFullName() : "N/A"); c1.setCellStyle(rowStyle);
                Cell c2 = row.createCell(2); c2.setCellValue(b.getTourName() != null ? b.getTourName() : "N/A"); c2.setCellStyle(rowStyle);
                Cell c3 = row.createCell(3); c3.setCellValue(b.getBookingDate() != null ? sdf.format(b.getBookingDate()) : ""); c3.setCellStyle(rowStyle);
                Cell c4 = row.createCell(4); c4.setCellValue(b.getNumberOfPeople()); c4.setCellStyle(rowStyle);
                Cell c5 = row.createCell(5); c5.setCellValue(VND_FORMAT.format(b.getTotalPrice()) + " VND"); c5.setCellStyle(rowStyle);
                Cell c6 = row.createCell(6); c6.setCellValue(b.getBookingStatus()); c6.setCellStyle(rowStyle);

                rowIdx++;
            }

            workbook.write(out);
        }
    }

    // =========================================================================
    // PDF: Hoa don chi tiet 1 Booking
    // =========================================================================

    public void exportBookingInvoicePdf(int bookingId, HttpServletResponse response) throws IOException {
        Booking booking = bookingDAO.findById(bookingId);
        if (booking == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Khong tim thay booking #" + bookingId);
            return;
        }

        Payment payment = paymentDAO.findByBookingId(bookingId);

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition",
                "inline; filename=hoa_don_booking_" + bookingId + ".pdf");

        try (OutputStream out = response.getOutputStream()) {
            Document doc = new Document(PageSize.A4, 50, 50, 60, 60);
            PdfWriter.getInstance(doc, out);
            doc.open();

            Color navyBlue  = new Color(5, 40, 93);
            Color oceanBlue = new Color(1, 148, 243);
            Color lightGray = new Color(242, 243, 243);
            Color green     = new Color(34, 197, 94);
            Color orange    = new Color(255, 94, 31);

            Font subtitleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Color.WHITE);
            Font labelFont    = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, navyBlue);
            Font valueFont    = FontFactory.getFont(FontFactory.HELVETICA, 10, Color.DARK_GRAY);
            Font smallFont    = FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY);
            Font totalFont    = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, navyBlue);

            // === HEADER ===
            PdfPTable headerTable = new PdfPTable(2);
            headerTable.setWidthPercentage(100);
            headerTable.setWidths(new float[]{1f, 2f});

            PdfPCell brandCell = new PdfPCell();
            brandCell.setBackgroundColor(navyBlue);
            brandCell.setPadding(15);
            brandCell.setBorder(Rectangle.NO_BORDER);
            Paragraph brandName = new Paragraph("VOYAGER ELITE\nTravel & Tours",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, Color.WHITE));
            brandName.setAlignment(Element.ALIGN_CENTER);
            brandCell.addElement(brandName);
            headerTable.addCell(brandCell);

            PdfPCell companyCell = new PdfPCell();
            companyCell.setBackgroundColor(oceanBlue);
            companyCell.setPadding(15);
            companyCell.setBorder(Rectangle.NO_BORDER);
            Paragraph companyInfo = new Paragraph();
            companyInfo.add(new Chunk("HOA DON DAT TOUR\n",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 16, Color.WHITE)));
            companyInfo.add(new Chunk("Travel Tour Booking Management System\n",
                    FontFactory.getFont(FontFactory.HELVETICA, 9, new Color(200, 230, 255))));
            companyInfo.add(new Chunk("Email: support@voyagerelite.vn",
                    FontFactory.getFont(FontFactory.HELVETICA, 9, new Color(200, 230, 255))));
            companyInfo.setAlignment(Element.ALIGN_RIGHT);
            companyCell.addElement(companyInfo);
            headerTable.addCell(companyCell);
            doc.add(headerTable);
            doc.add(Chunk.NEWLINE);

            // === So hoa don + Ngay ===
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            PdfPTable infoTable = new PdfPTable(2);
            infoTable.setWidthPercentage(100);

            PdfPCell invoiceNumCell = new PdfPCell();
            invoiceNumCell.setBorder(Rectangle.NO_BORDER);
            invoiceNumCell.setPadding(5);
            Paragraph invoiceNum = new Paragraph();
            invoiceNum.add(new Chunk("Ma Hoa Don: ", labelFont));
            invoiceNum.add(new Chunk("#INV-" + String.format("%06d", bookingId),
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, oceanBlue)));
            invoiceNumCell.addElement(invoiceNum);
            infoTable.addCell(invoiceNumCell);

            PdfPCell dateCell = new PdfPCell();
            dateCell.setBorder(Rectangle.NO_BORDER);
            dateCell.setPadding(5);
            Paragraph datePara = new Paragraph();
            datePara.add(new Chunk("Ngay xuat: ", labelFont));
            datePara.add(new Chunk(sdf.format(new java.util.Date()), valueFont));
            datePara.setAlignment(Element.ALIGN_RIGHT);
            dateCell.addElement(datePara);
            infoTable.addCell(dateCell);
            doc.add(infoTable);

            LineSeparator line = new LineSeparator(1, 100, oceanBlue, Element.ALIGN_CENTER, -5);
            doc.add(new Chunk(line));
            doc.add(Chunk.NEWLINE);

            // === Thong tin Khach Hang + Booking ===
            PdfPTable detailTable = new PdfPTable(2);
            detailTable.setWidthPercentage(100);
            detailTable.setSpacingBefore(5);
            detailTable.setSpacingAfter(10);

            PdfPCell custCell = new PdfPCell();
            custCell.setBorderColor(new Color(200, 210, 220));
            custCell.setPadding(12);
            custCell.setBackgroundColor(lightGray);
            Paragraph custTitle = new Paragraph("THONG TIN KHACH HANG",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, oceanBlue));
            custTitle.setSpacingAfter(6);
            custCell.addElement(custTitle);
            addRow(custCell, "Ho va ten:", booking.getFullName() != null ? booking.getFullName() : "N/A", labelFont, valueFont);
            detailTable.addCell(custCell);

            PdfPCell bookCell = new PdfPCell();
            bookCell.setBorderColor(new Color(200, 210, 220));
            bookCell.setPadding(12);
            bookCell.setBackgroundColor(lightGray);
            Paragraph bookTitle = new Paragraph("THONG TIN DAT TOUR",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 9, oceanBlue));
            bookTitle.setSpacingAfter(6);
            bookCell.addElement(bookTitle);
            addRow(bookCell, "Ma Booking:", "#" + booking.getBookingId(), labelFont, valueFont);
            addRow(bookCell, "Ngay dat:", booking.getBookingDate() != null ? sdf.format(booking.getBookingDate()) : "N/A", labelFont, valueFont);

            String statusDisplay = booking.getBookingStatus();
            Font statusFont = valueFont;
            if ("CONFIRMED".equals(statusDisplay))  { statusDisplay = "DA XAC NHAN"; statusFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, green); }
            else if ("COMPLETED".equals(statusDisplay)) { statusDisplay = "HOAN THANH";  statusFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, new Color(37, 99, 235)); }
            else if ("CANCELLED".equals(statusDisplay)) { statusDisplay = "DA HUY";      statusFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.RED); }
            else if ("PENDING".equals(statusDisplay))   { statusDisplay = "CHO XU LY";   statusFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, orange); }
            addRow(bookCell, "Trang thai:", statusDisplay, labelFont, statusFont);
            detailTable.addCell(bookCell);
            doc.add(detailTable);

            // === Bang chi tiet Tour ===
            PdfPTable tourTable = new PdfPTable(new float[]{3f, 1f, 2f, 2f});
            tourTable.setWidthPercentage(100);
            tourTable.setSpacingBefore(5);
            tourTable.setSpacingAfter(10);

            String[] tourHeaders = {"TEN TOUR", "SO NGUOI", "DON GIA / NGUOI", "THANH TIEN"};
            for (String h : tourHeaders) {
                PdfPCell hCell = new PdfPCell(new Phrase(h, subtitleFont));
                hCell.setBackgroundColor(navyBlue);
                hCell.setPadding(8);
                hCell.setHorizontalAlignment(Element.ALIGN_CENTER);
                tourTable.addCell(hCell);
            }

            double unitPrice = booking.getNumberOfPeople() > 0
                    ? booking.getTotalPrice() / booking.getNumberOfPeople()
                    : booking.getTotalPrice();

            PdfPCell tourNameCell = new PdfPCell(new Phrase(
                    booking.getTourName() != null ? booking.getTourName() : "N/A", valueFont));
            tourNameCell.setPadding(8);
            tourNameCell.setBackgroundColor(new Color(248, 250, 255));
            tourTable.addCell(tourNameCell);

            PdfPCell numCell = new PdfPCell(new Phrase(String.valueOf(booking.getNumberOfPeople()), valueFont));
            numCell.setPadding(8);
            numCell.setHorizontalAlignment(Element.ALIGN_CENTER);
            numCell.setBackgroundColor(new Color(248, 250, 255));
            tourTable.addCell(numCell);

            PdfPCell unitCell = new PdfPCell(new Phrase(VND_FORMAT.format(unitPrice) + " VND", valueFont));
            unitCell.setPadding(8);
            unitCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            unitCell.setBackgroundColor(new Color(248, 250, 255));
            tourTable.addCell(unitCell);

            PdfPCell totalCell = new PdfPCell(new Phrase(VND_FORMAT.format(booking.getTotalPrice()) + " VND",
                    FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, navyBlue)));
            totalCell.setPadding(8);
            totalCell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            totalCell.setBackgroundColor(new Color(248, 250, 255));
            tourTable.addCell(totalCell);
            doc.add(tourTable);

            // === Tong thanh toan ===
            PdfPTable totalTable = new PdfPTable(2);
            totalTable.setWidthPercentage(50);
            totalTable.setHorizontalAlignment(Element.ALIGN_RIGHT);

            PdfPCell labelCell2 = new PdfPCell(new Phrase("TONG THANH TOAN:", totalFont));
            labelCell2.setBorder(Rectangle.NO_BORDER);
            labelCell2.setPadding(8);
            labelCell2.setBackgroundColor(navyBlue);
            labelCell2.setHorizontalAlignment(Element.ALIGN_RIGHT);

            Font whiteTotal = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 13, Color.WHITE);
            PdfPCell amountCell = new PdfPCell(new Phrase(VND_FORMAT.format(booking.getTotalPrice()) + " VND", whiteTotal));
            amountCell.setBorder(Rectangle.NO_BORDER);
            amountCell.setPadding(8);
            amountCell.setBackgroundColor(oceanBlue);
            amountCell.setHorizontalAlignment(Element.ALIGN_RIGHT);

            totalTable.addCell(labelCell2);
            totalTable.addCell(amountCell);
            doc.add(totalTable);

            // === Payment info ===
            if (payment != null) {
                doc.add(Chunk.NEWLINE);
                PdfPTable payTable = new PdfPTable(1);
                payTable.setWidthPercentage(100);
                PdfPCell payCell = new PdfPCell();
                payCell.setBackgroundColor(new Color(240, 253, 244));
                payCell.setBorderColor(green);
                payCell.setPadding(10);
                Paragraph payTitle = new Paragraph("DA THANH TOAN",
                        FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, green));
                payTitle.setSpacingAfter(4);
                payCell.addElement(payTitle);
                SimpleDateFormat sdf2 = new SimpleDateFormat("dd/MM/yyyy");
                Paragraph payInfo = new Paragraph(
                        "Phuong thuc: " + (payment.getPaymentMethod() != null ? payment.getPaymentMethod() : "N/A")
                        + "   |   Ngay thanh toan: "
                        + (payment.getPaymentDate() != null ? sdf2.format(payment.getPaymentDate()) : "N/A"), smallFont);
                payCell.addElement(payInfo);
                payTable.addCell(payCell);
                doc.add(payTable);
            }

            // === Footer ===
            doc.add(Chunk.NEWLINE);
            doc.add(new Chunk(new LineSeparator(1, 100, lightGray, Element.ALIGN_CENTER, -5)));
            doc.add(Chunk.NEWLINE);
            Paragraph footer = new Paragraph(
                    "Cam on Quy khach da tin tuong va lua chon dich vu cua VoyagerElite!\n" +
                    "Moi thac mac xin lien he: support@voyagerelite.vn",
                    FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY));
            footer.setAlignment(Element.ALIGN_CENTER);
            doc.add(footer);

            doc.close();
        }
    }

    // =========================================================================
    // EXCEL: Bao cao doanh thu theo thang
    // =========================================================================

    public void exportRevenueToExcel(HttpServletResponse response) throws IOException {
        List<Booking> bookings = bookingDAO.getAllBookings();

        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=bao_cao_doanh_thu.xlsx");

        try (Workbook workbook = new XSSFWorkbook();
             OutputStream out = response.getOutputStream()) {

            Sheet sheet = workbook.createSheet("Doanh Thu Theo Thang");
            sheet.setColumnWidth(0, 4000);
            sheet.setColumnWidth(1, 3000);
            sheet.setColumnWidth(2, 5000);

            CellStyle headerStyle = workbook.createCellStyle();
            headerStyle.setFillForegroundColor(IndexedColors.DARK_BLUE.getIndex());
            headerStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            org.apache.poi.ss.usermodel.Font hf = workbook.createFont();
            hf.setColor(IndexedColors.WHITE.getIndex());
            hf.setBold(true);
            headerStyle.setFont(hf);
            headerStyle.setAlignment(HorizontalAlignment.CENTER);

            Row titleRow = sheet.createRow(0);
            titleRow.setHeight((short) 700);
            Cell titleCell = titleRow.createCell(0);
            titleCell.setCellValue("BAO CAO DOANH THU THEO THANG - VOYAGER ELITE");
            CellStyle ts = workbook.createCellStyle();
            org.apache.poi.ss.usermodel.Font tf = workbook.createFont();
            tf.setBold(true);
            tf.setFontHeightInPoints((short) 13);
            ts.setFont(tf);
            titleCell.setCellStyle(ts);
            sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(0, 0, 0, 2));

            String[] headers = {"Thang", "So Booking", "Doanh Thu (VND)"};
            Row headerRow = sheet.createRow(1);
            for (int i = 0; i < headers.length; i++) {
                Cell cell = headerRow.createCell(i);
                cell.setCellValue(headers[i]);
                cell.setCellStyle(headerStyle);
            }

            java.util.Map<String, double[]> revenueByMonth = new java.util.TreeMap<>();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");

            if (bookings != null) {
                for (Booking b : bookings) {
                    if ("COMPLETED".equals(b.getBookingStatus()) && b.getBookingDate() != null) {
                        String month = sdf.format(b.getBookingDate());
                        revenueByMonth.computeIfAbsent(month, k -> new double[]{0, 0});
                        revenueByMonth.get(month)[0]++;
                        revenueByMonth.get(month)[1] += b.getTotalPrice();
                    }
                }
            }

            int rowIdx = 2;
            double grandTotal = 0;
            for (java.util.Map.Entry<String, double[]> entry : revenueByMonth.entrySet()) {
                Row row = sheet.createRow(rowIdx++);
                row.createCell(0).setCellValue(entry.getKey());
                row.createCell(1).setCellValue((int) entry.getValue()[0]);
                row.createCell(2).setCellValue(VND_FORMAT.format(entry.getValue()[1]) + " VND");
                grandTotal += entry.getValue()[1];
            }

            Row totalRow = sheet.createRow(rowIdx);
            CellStyle totalStyle = workbook.createCellStyle();
            totalStyle.setFillForegroundColor(IndexedColors.LIGHT_YELLOW.getIndex());
            totalStyle.setFillPattern(FillPatternType.SOLID_FOREGROUND);
            org.apache.poi.ss.usermodel.Font totalFont = workbook.createFont();
            totalFont.setBold(true);
            totalStyle.setFont(totalFont);

            Cell totalLabelCell = totalRow.createCell(0);
            totalLabelCell.setCellValue("TONG CONG");
            totalLabelCell.setCellStyle(totalStyle);
            sheet.addMergedRegion(new org.apache.poi.ss.util.CellRangeAddress(rowIdx, rowIdx, 0, 1));

            Cell totalValueCell = totalRow.createCell(2);
            totalValueCell.setCellValue(VND_FORMAT.format(grandTotal) + " VND");
            totalValueCell.setCellStyle(totalStyle);

            workbook.write(out);
        }
    }

    // =========================================================================
    // Helper
    // =========================================================================

    private void addRow(PdfPCell cell, String label, String value,
                        Font labelFont, Font valueFont) {
        Paragraph p = new Paragraph();
        p.add(new Chunk(label + " ", labelFont));
        p.add(new Chunk(value, valueFont));
        p.setSpacingAfter(3);
        cell.addElement(p);
    }
}
