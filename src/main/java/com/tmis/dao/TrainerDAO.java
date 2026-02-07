package com.tmis.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import com.tmis.model.Trainer;
import com.tmis.util.DBUtil;

public class TrainerDAO {

    // 1️⃣ Add Trainer (valid = 0 by default)
    public boolean addTrainer(Trainer t) {

        String sql = "INSERT INTO tmis.trainer_master "
                   + "(trainer_name, trainer_designation, employee_id, type, office, valid) "
                   + "VALUES (?, ?, ?, ?, ?, 0)";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, t.getTrainerName());
            pst.setString(2, t.getTrainerDesignation());
            pst.setString(3, t.getEmployeeId());
            pst.setString(4, t.getType());
            pst.setString(5, t.getOffice());

            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 2️⃣ Get ALL Trainers (Active + Disabled)
    public List<Trainer> getAllTrainers() {

        List<Trainer> list = new ArrayList<>();

        String sql = "SELECT * FROM tmis.trainer_master ORDER BY trainer_id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {

            while (rs.next()) {
                Trainer t = new Trainer();
                t.setTrainerId(rs.getInt("trainer_id"));
                t.setTrainerName(rs.getString("trainer_name"));
                t.setTrainerDesignation(rs.getString("trainer_designation"));
                t.setEmployeeId(rs.getString("employee_id"));
                t.setType(rs.getString("type"));
                t.setOffice(rs.getString("office"));
                t.setValid(rs.getInt("valid"));

                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 3️⃣ Get Trainer by ID (for Edit)
    public Trainer getTrainerById(int trainerId) {

        Trainer t = null;

        String sql = "SELECT * FROM tmis.trainer_master WHERE trainer_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, trainerId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                t = new Trainer();
                t.setTrainerId(rs.getInt("trainer_id"));
                t.setTrainerName(rs.getString("trainer_name"));
                t.setTrainerDesignation(rs.getString("trainer_designation"));
                t.setEmployeeId(rs.getString("employee_id"));
                t.setType(rs.getString("type"));
                t.setOffice(rs.getString("office"));
                t.setValid(rs.getInt("valid"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return t;
    }

    // 4️⃣ Update Trainer
    public boolean updateTrainer(Trainer t) {

        String sql = "UPDATE tmis.trainer_master SET "
                   + "trainer_name=?, trainer_designation=?, employee_id=?, "
                   + "type=?, office=? WHERE trainer_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setString(1, t.getTrainerName());
            pst.setString(2, t.getTrainerDesignation());
            pst.setString(3, t.getEmployeeId());
            pst.setString(4, t.getType());
            pst.setString(5, t.getOffice());
            pst.setInt(6, t.getTrainerId());

            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 5️⃣ Disable Trainer (valid = 1)
    public boolean disableTrainer(int trainerId) {

        String sql = "UPDATE tmis.trainer_master SET valid=1 WHERE trainer_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, trainerId);
            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 6️⃣ Enable Trainer (optional, future use)
    public boolean enableTrainer(int trainerId) {

        String sql = "UPDATE tmis.trainer_master SET valid=0 WHERE trainer_id=?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pst = conn.prepareStatement(sql)) {

            pst.setInt(1, trainerId);
            return pst.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Trainer> getActiveTrainers() {

        List<Trainer> list = new ArrayList<>();

        String sql =
            "SELECT trainer_id, trainer_name, trainer_designation, office " +
            "FROM tmis.trainer_master " +
            "WHERE valid = 0 " +
            "ORDER BY trainer_name";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Trainer t = new Trainer();
                t.setTrainerId(rs.getInt("trainer_id"));
                t.setTrainerName(rs.getString("trainer_name"));
                t.setTrainerDesignation(rs.getString("trainer_designation"));
                t.setOffice(rs.getString("office"));
                list.add(t);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
    
//    public Trainer getTrainerById(int trainerId) {
//
//        Trainer t = null;
//
//        String sql =
//            "SELECT trainer_id, trainer_name, trainer_designation, office " +
//            "FROM tmis.trainer_master " +
//            "WHERE trainer_id = ?";
//
//        try (Connection conn = DBUtil.getConnection();
//             PreparedStatement ps = conn.prepareStatement(sql)) {
//
//            ps.setInt(1, trainerId);
//            ResultSet rs = ps.executeQuery();
//
//            if (rs.next()) {
//                t = new Trainer();
//                t.setTrainerId(rs.getInt("trainer_id"));
//                t.setTrainerName(rs.getString("trainer_name"));
//                t.setTrainerDesignation(rs.getString("trainer_designation"));
//                t.setOffice(rs.getString("office"));
//            }
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        return t;
//    }
    
    public boolean isTrainerAvailable(
            int trainerId,
            java.sql.Date slotDate,
            String timeFrom,
            String timeTo) {

        String sql =
            "SELECT COUNT(*) " +
            "FROM tmis.slot_trainer_map stm " +
            "JOIN tmis.timetable_slot ts ON stm.slot_id = ts.slot_id " +
            "WHERE stm.trainer_id = ? " +
            "AND ts.slot_date = ? " +
            "AND ( ? < ts.time_to AND ? > ts.time_from )";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, trainerId);
            ps.setDate(2, slotDate);
            ps.setString(3, timeFrom);
            ps.setString(4, timeTo);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) == 0; // true = available
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }

}

