namespace PeopleProfile
{
    partial class Form1
    {
        /// <summary>
        ///  Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        ///  Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        ///  Required method for Designer support - do not modify
        ///  the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            btnLoad = new Button();
            btnSave = new Button();
            dgvPers = new DataGridView();
            btnNew = new Button();
            btnEdit = new Button();
            btnDelete = new Button();
            label1 = new Label();
            picPhoto = new PictureBox();
            ((System.ComponentModel.ISupportInitialize)dgvPers).BeginInit();
            ((System.ComponentModel.ISupportInitialize)picPhoto).BeginInit();
            SuspendLayout();
            // 
            // btnLoad
            // 
            btnLoad.Location = new Point(24, 13);
            btnLoad.Margin = new Padding(3, 2, 3, 2);
            btnLoad.Name = "btnLoad";
            btnLoad.Size = new Size(82, 22);
            btnLoad.TabIndex = 0;
            btnLoad.Text = "Load";
            btnLoad.UseVisualStyleBackColor = true;
            // 
            // btnSave
            // 
            btnSave.Location = new Point(314, 20);
            btnSave.Margin = new Padding(3, 2, 3, 2);
            btnSave.Name = "btnSave";
            btnSave.Size = new Size(82, 22);
            btnSave.TabIndex = 1;
            btnSave.Text = "Save";
            btnSave.UseVisualStyleBackColor = true;
            // 
            // dgvPers
            // 
            dgvPers.AllowUserToAddRows = false;
            dgvPers.AllowUserToDeleteRows = false;
            dgvPers.AutoSizeRowsMode = DataGridViewAutoSizeRowsMode.AllCellsExceptHeaders;
            dgvPers.ColumnHeadersHeightSizeMode = DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            dgvPers.Location = new Point(28, 46);
            dgvPers.Margin = new Padding(3, 2, 3, 2);
            dgvPers.Name = "dgvPers";
            dgvPers.ReadOnly = true;
            dgvPers.RowHeadersWidth = 51;
            dgvPers.Size = new Size(368, 242);
            dgvPers.TabIndex = 2;
            // 
            // btnNew
            // 
            btnNew.Location = new Point(620, 86);
            btnNew.Margin = new Padding(3, 2, 3, 2);
            btnNew.Name = "btnNew";
            btnNew.Size = new Size(82, 22);
            btnNew.TabIndex = 3;
            btnNew.Text = "New";
            btnNew.UseVisualStyleBackColor = true;
            // 
            // btnEdit
            // 
            btnEdit.Location = new Point(620, 131);
            btnEdit.Margin = new Padding(3, 2, 3, 2);
            btnEdit.Name = "btnEdit";
            btnEdit.Size = new Size(82, 22);
            btnEdit.TabIndex = 4;
            btnEdit.Text = "Edit";
            btnEdit.UseVisualStyleBackColor = true;
            // 
            // btnDelete
            // 
            btnDelete.Location = new Point(621, 266);
            btnDelete.Margin = new Padding(3, 2, 3, 2);
            btnDelete.Name = "btnDelete";
            btnDelete.Size = new Size(82, 22);
            btnDelete.TabIndex = 5;
            btnDelete.Text = "Delete";
            btnDelete.UseVisualStyleBackColor = true;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(411, 62);
            label1.Name = "label1";
            label1.Size = new Size(82, 15);
            label1.TabIndex = 6;
            label1.Text = "Current Photo";
            // 
            // picPhoto
            // 
            picPhoto.Location = new Point(415, 82);
            picPhoto.Margin = new Padding(3, 2, 3, 2);
            picPhoto.Name = "picPhoto";
            picPhoto.Size = new Size(200, 206);
            picPhoto.TabIndex = 7;
            picPhoto.TabStop = false;
            // 
            // Form1
            // 
            AutoScaleDimensions = new SizeF(7F, 15F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(714, 304);
            Controls.Add(picPhoto);
            Controls.Add(label1);
            Controls.Add(btnDelete);
            Controls.Add(btnEdit);
            Controls.Add(btnNew);
            Controls.Add(dgvPers);
            Controls.Add(btnSave);
            Controls.Add(btnLoad);
            Margin = new Padding(3, 2, 3, 2);
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "Form1";
            Text = "People";
            Load += Form1_Load;
            ((System.ComponentModel.ISupportInitialize)dgvPers).EndInit();
            ((System.ComponentModel.ISupportInitialize)picPhoto).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button btnLoad;
        private Button btnSave;
        private DataGridView dgvPers;
        private Button btnNew;
        private Button btnEdit;
        private Button btnDelete;
        private Label label1;
        private PictureBox picPhoto;
    }
}
