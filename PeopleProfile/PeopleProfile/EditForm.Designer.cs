namespace PeopleProfile
{
    partial class EditForm
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
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
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            btnBrowse = new Button();
            picPhoto = new PictureBox();
            label3 = new Label();
            txtAge = new TextBox();
            label2 = new Label();
            txtName = new TextBox();
            label1 = new Label();
            btnUpdate = new Button();
            btnCancel = new Button();
            btnClear = new Button();
            ((System.ComponentModel.ISupportInitialize)picPhoto).BeginInit();
            SuspendLayout();
            // 
            // btnBrowse
            // 
            btnBrowse.Location = new Point(243, 151);
            btnBrowse.Name = "btnBrowse";
            btnBrowse.Size = new Size(94, 29);
            btnBrowse.TabIndex = 17;
            btnBrowse.Text = "Browse";
            btnBrowse.UseVisualStyleBackColor = true;
            // 
            // picPhoto
            // 
            picPhoto.Location = new Point(87, 191);
            picPhoto.Name = "picPhoto";
            picPhoto.Size = new Size(250, 268);
            picPhoto.SizeMode = PictureBoxSizeMode.StretchImage;
            picPhoto.TabIndex = 16;
            picPhoto.TabStop = false;
            // 
            // label3
            // 
            label3.AutoSize = true;
            label3.Location = new Point(19, 151);
            label3.Name = "label3";
            label3.Size = new Size(48, 20);
            label3.TabIndex = 15;
            label3.Text = "Photo";
            // 
            // txtAge
            // 
            txtAge.Location = new Point(87, 103);
            txtAge.Name = "txtAge";
            txtAge.Size = new Size(74, 27);
            txtAge.TabIndex = 14;
            // 
            // label2
            // 
            label2.AutoSize = true;
            label2.Location = new Point(19, 106);
            label2.Name = "label2";
            label2.Size = new Size(36, 20);
            label2.TabIndex = 13;
            label2.Text = "Age";
            // 
            // txtName
            // 
            txtName.Location = new Point(87, 59);
            txtName.Name = "txtName";
            txtName.Size = new Size(252, 27);
            txtName.TabIndex = 12;
            // 
            // label1
            // 
            label1.AutoSize = true;
            label1.Location = new Point(19, 62);
            label1.Name = "label1";
            label1.Size = new Size(49, 20);
            label1.TabIndex = 11;
            label1.Text = "Name";
            // 
            // btnUpdate
            // 
            btnUpdate.Location = new Point(245, 12);
            btnUpdate.Name = "btnUpdate";
            btnUpdate.Size = new Size(94, 29);
            btnUpdate.TabIndex = 10;
            btnUpdate.Text = "Update";
            btnUpdate.UseVisualStyleBackColor = true;
            // 
            // btnCancel
            // 
            btnCancel.Location = new Point(15, 10);
            btnCancel.Name = "btnCancel";
            btnCancel.Size = new Size(94, 29);
            btnCancel.TabIndex = 9;
            btnCancel.Text = "Cancel";
            btnCancel.UseVisualStyleBackColor = true;
            // 
            // btnClear
            // 
            btnClear.Location = new Point(88, 152);
            btnClear.Name = "btnClear";
            btnClear.Size = new Size(94, 29);
            btnClear.TabIndex = 18;
            btnClear.Text = "Clear";
            btnClear.UseVisualStyleBackColor = true;
            // 
            // EditForm
            // 
            AutoScaleDimensions = new SizeF(8F, 20F);
            AutoScaleMode = AutoScaleMode.Font;
            ClientSize = new Size(377, 476);
            Controls.Add(btnClear);
            Controls.Add(btnBrowse);
            Controls.Add(picPhoto);
            Controls.Add(label3);
            Controls.Add(txtAge);
            Controls.Add(label2);
            Controls.Add(txtName);
            Controls.Add(label1);
            Controls.Add(btnUpdate);
            Controls.Add(btnCancel);
            MaximizeBox = false;
            MinimizeBox = false;
            Name = "EditForm";
            Text = "Editing";
            ((System.ComponentModel.ISupportInitialize)picPhoto).EndInit();
            ResumeLayout(false);
            PerformLayout();
        }

        #endregion

        private Button btnBrowse;
        private PictureBox picPhoto;
        private Label label3;
        private TextBox txtAge;
        private Label label2;
        private TextBox txtName;
        private Label label1;
        private Button btnUpdate;
        private Button btnCancel;
        private Button btnClear;
    }
}