using System;
using System.Collections.Generic;

using System.Web;


    public class issuesBO
    {
        public Int64 issueId
        {
            set;
            get;
        }
        public Int64 guid
        {
            set;
            get;
        }
        public Int64 mpId
        {
            set;
            get;
        }

        public string issueText
        {
            set;
            get;
        }
        public string evidencePath
        {
            set;
            get;
        }
        public DateTime postedOn
        {
            set;
            get;
        }
        public Int64 evidenceId
        {
            set;
            get;
        }
        public Boolean enable
        {
            set;
            get;
        }
    }
