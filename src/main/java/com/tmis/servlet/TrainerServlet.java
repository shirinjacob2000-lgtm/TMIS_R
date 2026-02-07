package com.tmis.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tmis.dao.TrainerDAO;
import com.tmis.model.Trainer;

@WebServlet("/user/trainers")
//@WebServlet("/TrainerServlet")
public class TrainerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private TrainerDAO trainerDAO;

	@Override
	public void init() {
		trainerDAO = new TrainerDAO();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if (action == null || action.equals("list")) {
			listTrainers(request, response);

		} else if (action.equals("edit")) {
			showEditForm(request, response);

		} else if (action.equals("disable")) {
			disableTrainer(request, response);

		} else if (action.equals("enable")) {
			enableTrainer(request, response);

		} else {
			listTrainers(request, response);
		}
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		if ("add".equals(action)) {
			addTrainer(request, response);

		} else if ("update".equals(action)) {
			updateTrainer(request, response);

		} else {
			response.sendRedirect(request.getContextPath() + "/user/trainers");
		}
	}

	// ================= METHODS =================

	private void listTrainers(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		List<Trainer> trainerList = trainerDAO.getAllTrainers();
		// System.out.println("Trainer count = " + trainerList.size());
		request.setAttribute("trainerList", trainerList);

		request.getRequestDispatcher("/user/manage-trainers.jsp").forward(request, response);
	}

	private void addTrainer(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Trainer t = new Trainer();
		t.setTrainerName(request.getParameter("trainerName"));
		t.setTrainerDesignation(request.getParameter("trainerDesignation"));
		t.setEmployeeId(request.getParameter("employeeId"));
		t.setType(request.getParameter("type"));
		t.setOffice(request.getParameter("office"));
		t.setValid(0); // ACTIVE

		trainerDAO.addTrainer(t);

		response.sendRedirect(request.getContextPath() + "/user/trainers");
	}

	private void showEditForm(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		Trainer trainer = trainerDAO.getTrainerById(id);
		
		if (trainer == null || trainer.getValid() != 0) {
	        response.sendRedirect(request.getContextPath() + "/user/trainers");
	        return;
	    }

		request.setAttribute("trainer", trainer);
		request.getRequestDispatcher("/user/edit-trainer.jsp").forward(request, response);
	}

	private void updateTrainer(HttpServletRequest request, HttpServletResponse response) throws IOException {

		Trainer t = new Trainer();
		t.setTrainerId(Integer.parseInt(request.getParameter("trainerId")));
		t.setTrainerName(request.getParameter("trainerName"));
		t.setTrainerDesignation(request.getParameter("trainerDesignation"));
		t.setEmployeeId(request.getParameter("employeeId"));
		t.setType(request.getParameter("type"));
		t.setOffice(request.getParameter("office"));

		// trainerDAO.updateTrainer(t);

		boolean updated = trainerDAO.updateTrainer(t);

		if (updated) {
			response.sendRedirect(request.getContextPath() + "/user/trainers?msg=updated");
		} else {
			response.sendRedirect(request.getContextPath() + "/user/trainers?error=update");
		}

		// response.sendRedirect(request.getContextPath() + "/user/trainers");
	}

	private void disableTrainer(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		trainerDAO.disableTrainer(id);

		response.sendRedirect(request.getContextPath() + "/user/trainers?msg=disabled");
		return;
	}

	private void enableTrainer(HttpServletRequest request, HttpServletResponse response) throws IOException {

		int id = Integer.parseInt(request.getParameter("id"));
		trainerDAO.enableTrainer(id);

		response.sendRedirect(request.getContextPath() + "/user/trainers?msg=enabled");
		return;
	}
}
